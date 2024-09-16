package com.example.nothing_pomodoro

import android.content.ComponentName
import android.os.CountDownTimer
import android.util.Log
import com.nothing.ketchum.Common
import com.nothing.ketchum.GlyphException
import com.nothing.ketchum.GlyphFrame
import com.nothing.ketchum.GlyphManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.math.ceil
import kotlin.math.floor
import kotlin.math.max
import kotlin.math.min


class MainActivity: FlutterActivity() {
    companion object {
        private const val CHANNEL = "nothingpomodoro.glyph.notification"
        private  const val SEND_CHANNEL = "glyph.status"
    }
    private lateinit var manager :GlyphManager
    private var timer: CountDownTimer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val service = PomodoroService(flutterEngine)
        manager = GlyphManager.getInstance(applicationContext)
        manager.init( object: GlyphManager.Callback {
            override fun onServiceConnected(componentName: ComponentName) {
                if (Common.is23111()) manager.register(Common.DEVICE_23111)
                try {
                    manager.openSession()
                } catch (e: GlyphException) {

                }
            }

            override fun onServiceDisconnected(componentName: ComponentName) {
                manager.closeSession()
            }
        })
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            // TDDO: turn to intent foreground service
            if(call.method == "startFocus") {
//                val intent = Intent(context, service.javaClass)
                val time = call.argument<Int>("time")?:0
                Log.d("focus", time.toString())
//                intent.putExtra("type", type)
//                intent.putExtra("time", time)
//                intent.putExtra("messenger", flutterEngine.dartExecutor.binaryMessenger)
//                startService(intent)
//                print("start service")
//                val builder = manager.glyphFrameBuilder
                var toggleSubChannel = true
                val typeToGlyphId = arrayOf(25,25,24)
                manager.turnOff()

                val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SEND_CHANNEL)

                timer = object : CountDownTimer(time.toLong() ?: 0 ,1000) {

                    override fun onTick(millisUntilFinished: Long) {
                        channel.invokeMethod("remainMillsecounds", millisUntilFinished.toInt())
                        val progress  = (millisUntilFinished.toInt() / time.toDouble())
                        var channelCId = 0
                        if (Common.is23111()) {
                            channelCId = floor(progress * 23.0).toInt()
                        }
                        /// frame builder is stacked
                        /// call multiple buildChannel will stack or override the frame
                        var frame: GlyphFrame.Builder = manager.glyphFrameBuilder
                        for (i in 0..channelCId) {
                            frame = frame.buildChannel(i, max(800, ceil(progress * 4000.0).toInt()))
                        }

                        /// GlyphFrame: private static int DEFAULT_LIGHT = 4000;
                        /// set Channel light
                        /// Builder: channel.set(channel, GlyphFrame.DEFAULT_LIGHT);

                        /// In manager file
                        /// private static final int DEFAULT_MAX_LIGHT = 4096;
                        /// private static final int DEFAULT_MIN_LIGHT = 800;
                        /// private static final int NO_LIGHT = 0;

                        /// frame animation is use system time check in a for loop with in interval
                        /// and use a async task closure to add loop function

                        if(toggleSubChannel) {
                            val addedCId: Int = min(channelCId + 1,23)
//                            frame = frame.buildChannel(typeToGlyphId[type], max(800, ceil(progress * 4000.0).toInt()))
                            frame = frame.buildChannel(addedCId, max(800, ceil(progress * 4000.0).toInt()))
                            toggleSubChannel = false
                        }else {
                            toggleSubChannel = true
                        }
                        Log.d("Glyph Progress","${progress}")
                        manager.toggle(frame.build())
                    }

                    override fun onFinish() {
//                        channel.invokeMethod("timerFinish", null)
                        manager.turnOff()
                    }
                }

                timer?.start()
            }

            if(call.method == "forceEndTimer" || call.method == "pauseTimer") {
                if(timer != null) {
                    timer!!.cancel()
                    manager.turnOff()
                }
            }

            if(call.method == "startBreak") {
                val time = call.argument<Int>("time")?:0
                var toggleSubChannel = true
//                val typeToGlyphId = arrayOf(25,25,24)
                manager.turnOff()

                val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SEND_CHANNEL)

                timer = object : CountDownTimer(time.toLong() ?: 0 ,1000) {
                    override fun onTick(millisUntilFinished: Long) {
                        channel.invokeMethod("remainMillsecounds", millisUntilFinished.toInt())
                        val progress  = (millisUntilFinished.toInt() / time.toDouble())
                        var channelCId = 0
                        if (Common.is23111()) {
                            channelCId = ceil((1-progress) * 23.0).toInt()
                        }
                        /// frame builder is stacked
                        /// call multiple buildChannel will stack or override the frame
                        var frame: GlyphFrame.Builder = manager.glyphFrameBuilder
                        for (i in 0..channelCId) {
                            frame = frame.buildChannel(i, max(800, ceil((1-progress) * 4000.0).toInt()))
                        }

                        /// GlyphFrame: private static int DEFAULT_LIGHT = 4000;
                        /// set Channel light
                        /// Builder: channel.set(channel, GlyphFrame.DEFAULT_LIGHT);

                        /// In manager file
                        /// private static final int DEFAULT_MAX_LIGHT = 4096;
                        /// private static final int DEFAULT_MIN_LIGHT = 800;
                        /// private static final int NO_LIGHT = 0;

                        /// frame animation is use system time check in a for loop with in interval
                        /// and use a async task closure to add loop function

                        if(toggleSubChannel) {
                            val addedCId: Int = min(channelCId + 1,23)
                            frame = frame.buildChannel(addedCId, max(800, ceil(progress * 4000.0).toInt()))
                            toggleSubChannel = false
                        }else {
                            toggleSubChannel = true
                        }
                        Log.d("Glyph Progress","${progress}")
                        manager.toggle(frame.build())
                    }

                    override fun onFinish() {
//                        channel.invokeMethod("timerFinish", mapOf(Pair("type", "break")))
                        manager.turnOff()
                    }
                }

                timer?.start()
            }
        };

    }

    override fun onDestroy() {
        timer?.cancel()
        timer = null
        manager.turnOff()
        manager.unInit()
        super.onDestroy()
    }
}
