package com.example.nothing_pomodoro

import android.app.Service
import android.content.ComponentName
import android.content.Intent
import android.os.Binder
import android.os.IBinder
import com.nothing.ketchum.Common
import com.nothing.ketchum.GlyphException
import com.nothing.ketchum.GlyphManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class PomodoroService(val engine: FlutterEngine) : Service() {
    private lateinit var manager: GlyphManager;
    private val CHANNEL = "glyph";
    private lateinit var methodChannel: MethodChannel;

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        return super.onStartCommand(intent, flags, startId)
    }

    override fun onCreate() {
        super.onCreate()
        manager = GlyphManager.getInstance(applicationContext);
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
        val builder = manager.glyphFrameBuilder
        val frame = builder.buildChannelC().buildInterval(10)
                .buildCycles(2).buildPeriod(3000).build()
        manager.animate(frame)
        methodChannel =  MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
    }

    override fun onDestroy() {
        manager.closeSession();
        methodChannel.invokeMethod("endTimer", null);
        super.onDestroy()
    }


    override fun onBind(intent: Intent?): IBinder? {
       return LocalBinder();
    }


    class LocalBinder: Binder() {
        fun getService(): Service? {
            return this.getService()
        }
    }
}