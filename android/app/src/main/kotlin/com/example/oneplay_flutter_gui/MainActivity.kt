package com.example.oneplay_flutter_gui

import io.flutter.embedding.android.FlutterActivity
import android.view.*
import android.util.Log

class MainActivity: FlutterActivity() {
    override fun dispatchKeyEvent(event: KeyEvent?): Boolean {
		event?.let { it ->
            val input = InputDevice.getDevice(it.deviceId)
			when {
                input == null -> {
                    Log.i("MainActivity", "dispatchKeyEvent: Not Found InputDevice Information.")
				    return super.dispatchKeyEvent(it)
                }
                input.sources and InputDevice.SOURCE_GAMEPAD == InputDevice.SOURCE_GAMEPAD && it.keyCode == KeyEvent.KEYCODE_BACK -> {
                    Log.i("MainActivity", "dispatchKeyEvent: Detected Gamepad's Back Button.")
                    return false
                }

                else -> return super.dispatchKeyEvent(it)
			}
		} ?: kotlin.run { return super.dispatchKeyEvent(event) }
	}
}
