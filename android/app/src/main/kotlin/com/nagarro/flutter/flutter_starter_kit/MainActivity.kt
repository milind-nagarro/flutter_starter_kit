package com.nagarro.flutter.flutter_starter_kit

import Processors.*
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.facetec.sdk.FaceTecIDScanResult
import com.facetec.sdk.FaceTecSDK
import com.facetec.sdk.FaceTecSessionResult
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import okhttp3.Callback
import okhttp3.Response
import org.json.JSONException
import org.json.JSONObject
import java.io.IOException
import java.util.*

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.facetec.poc"

    private var latestSessionResult: FaceTecSessionResult? = null
    private var latestIDScanResult: FaceTecIDScanResult? = null
    private var latestProcessor: Processor? = null
    private var isSessionPreparingToLaunch = false

    private lateinit var resultCallback: (result: Boolean) -> Unit

    private var channelResult: MethodChannel.Result? = null

    companion object {
        lateinit var latestExternalDatabaseRefID: String
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Config.initializeFaceTecSDKFromAutogeneratedConfig(this, object :
            FaceTecSDK.InitializeCallback() {
            override fun onCompletion(completed: Boolean) {
                Log.d("FaceTec", "Initialization Successful ? : $completed")
            }
        })
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            channelResult = result
            when (call.method) {
                "LivenessCheck" -> onLivenessCheckPressed()
                "EnrollUser" -> onEnrollUserPressed()
                "AuthenticateUser" -> onAuthenticateUserPressed()
                "PhotoIDMatch" -> onPhotoIDMatchPressed()
            }
        }
    }


    // Perform Liveness Check.
    private fun onLivenessCheckPressed() {
        isSessionPreparingToLaunch = true
        getSessionToken(object : SessionTokenCallback {
            override fun onSessionTokenReceived(sessionToken: String?) {
                isSessionPreparingToLaunch = false
                latestProcessor = LivenessCheckProcessor(sessionToken, this@MainActivity)
            }
        })
    }

    // Perform Enrollment, generating a username each time to guarantee uniqueness.
    private fun onEnrollUserPressed() {
        isSessionPreparingToLaunch = true
        getSessionToken(object : SessionTokenCallback {
            override fun onSessionTokenReceived(sessionToken: String?) {
                isSessionPreparingToLaunch = false
                latestExternalDatabaseRefID = "android_sample_app_" + UUID.randomUUID()
                latestProcessor = EnrollmentProcessor(sessionToken, this@MainActivity)
            }
        })
    }

    // Perform Authentication, using the username from Enrollment.
    private fun onAuthenticateUserPressed() {
        isSessionPreparingToLaunch = true
        if (latestExternalDatabaseRefID.isEmpty()) {
            Log.d("FaceTec", "Please enroll first before trying authentication.")
            return
        }
        getSessionToken(object : SessionTokenCallback {
            override fun onSessionTokenReceived(sessionToken: String?) {
                isSessionPreparingToLaunch = false
                latestProcessor = AuthenticateProcessor(sessionToken, this@MainActivity)
            }
        })
    }

    // Perform Photo ID Match, generating a username each time to guarantee uniqueness.
    private fun onPhotoIDMatchPressed() {
        isSessionPreparingToLaunch = true
        getSessionToken(object : SessionTokenCallback {
            override fun onSessionTokenReceived(sessionToken: String?) {
                isSessionPreparingToLaunch = false
                latestExternalDatabaseRefID = "android_sample_app_" + UUID.randomUUID()
                latestProcessor = PhotoIDMatchProcessor(
                    sessionToken,
                    this@MainActivity
                )
            }
        })
    }

    // When the FaceTec SDK is completely done, you receive control back here.
// Since you have already handled all results in your Processor code, how you proceed here is up to you and how your App works.
// In general, there was either a Success, or there was some other case where you cancelled out.
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (latestProcessor == null) {
            return
        }

        // At this point, you have already handled all results in your Processor code.
        if (this.latestProcessor!!.isSuccess) {
            Log.d("FaceTec", "Success")
            channelResult?.success(true)
        } else {
            Log.d("FaceTec", "Session exited early, see logs for more details.")
            // Reset the enrollment identifier.
            latestExternalDatabaseRefID = ""
            channelResult?.error("FAILURE", "Error", false)
        }
    }

    //
// DEVELOPER NOTE:  This is a convenience function for demonstration purposes only so the Sample App can have access to the latest session results.
// In your code, you may not even want or need to do this.
//
    fun setLatestSessionResult(sessionResult: FaceTecSessionResult) {
        this.latestSessionResult = sessionResult
    }

    //
// DEVELOPER NOTE:  This is a convenience function for demonstration purposes only so the Sample App can have access to the latest id scan results.
// In your code, you may not even want or need to do this.
//
    fun setLatestIDScanResult(idScanResult: FaceTecIDScanResult) {
        this.latestIDScanResult = idScanResult
    }

    private fun getSessionToken(sessionTokenCallback: SessionTokenCallback) {
        // Do the network call and handle result
        val request: okhttp3.Request = okhttp3.Request.Builder()
            .header("X-Device-Key", Config.DeviceKeyIdentifier)
            .header("User-Agent", FaceTecSDK.createFaceTecAPIUserAgentString(""))
            .url(Config.BaseURL + "/session-token")
            .get()
            .build()
        NetworkingHelpers.getApiClient().newCall(request).enqueue(object : Callback {
            override fun onFailure(call: okhttp3.Call, e: IOException) {
                e.printStackTrace()
                Log.d("FaceTecSDKSampleApp", "Exception raised while attempting HTTPS call.")

                // If this comes from HTTPS cancel call, don't set the sub code to NETWORK_ERROR.
                if (e.message != NetworkingHelpers.OK_HTTP_RESPONSE_CANCELED) {
                    Log.e("FaceTec", "Error getting server session token")
                }
            }

            override fun onResponse(call: okhttp3.Call, response: Response) {
                val responseString: String =
                    response.body()?.string() ?: response.body()?.close().toString()
                try {
                    val responseJSON = JSONObject(responseString)
                    if (responseJSON.has("sessionToken")) {
//                        utils.hideSessionTokenConnectionText()
                        sessionTokenCallback.onSessionTokenReceived(responseJSON.getString("sessionToken"))
                    } else {
                        Log.e("FaceTec", "Error getting server session token")
                    }
                } catch (e: JSONException) {
                    e.printStackTrace()
                    Log.d(
                        "FaceTecSDKSampleApp",
                        "Exception raised while attempting to parse JSON result."
                    )
                    Log.e("FaceTec", "Error getting server session token")
                }
            }
        })
    }

    interface SessionTokenCallback {
        fun onSessionTokenReceived(sessionToken: String?)
    }

}
