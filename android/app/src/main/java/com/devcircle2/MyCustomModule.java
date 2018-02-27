package com.devcircle2;

import android.support.annotation.Nullable;
import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;

/**
 * @author Anh Tuan Nguyen
 * @email tuan@agiletech.vn
 * @website agiletech.vn
 * @version 1.0.0
 * @since 02-25-2018
 */
public class MyCustomModule extends ReactContextBaseJavaModule {
    public MyCustomModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "MyCustomModule";
    }

    /**
     * hello method, return simple string back to js world using callback
     *
     * @param name String
     * @param callback Callback
     */
    @ReactMethod
    public void hello(String name, Callback callback) {
        String helloString = "Hi " + name + ", Welcome to native world";
        callback.invoke(helloString);
    }

    /**
     * personInfo method, return complex data back to js world using callback
     *
     * @param firstName String
     * @param lastName String
     * @param age Integer
     * @param salary Double
     * @param gender Boolean
     * @param array ReadableArray
     * @param object ReadableMap
     * @param callback Callback
     */
    @ReactMethod
    public void personInfo(
            String firstName, String lastName, Integer age, Double salary,
            Boolean gender, @Nullable ReadableArray array, @Nullable ReadableMap object, Callback callback) {
        // create an object to return back JS
        WritableMap data= Arguments.createMap();
        data.putString("firstName", firstName);
        data.putString("lastName", lastName);
        data.putInt("age", age);
        data.putDouble("salary", salary);
        data.putBoolean("gender", gender);
        data.putString("genderStr", gender ? "male" : "female");

        // array is nullable, we just ignore it if null
        if(null != array) {
            data.putArray("array", Utils.convertReadableArrayToWritableArray(array));
        }

        // object is nullable
        if(null != object) {
            data.putMap("object", Utils.convertReadableMapToWritableMap(object));
        }

        // options
        WritableArray options = Arguments.createArray();
        options.pushString("One");
        options.pushString("True");
        options.pushString("Three");

        // date
        WritableMap date = Arguments.createMap();
        date.putInt("Mon", 2);
        date.putInt("Tue", 3);
        date.putInt("Sat", 7);

        // push date object to options array
        options.pushMap(date);

        // push options array into data object
        data.putArray("options", options);
        callback.invoke(data);
    }

    /**
     * async await method
     *
     * @param signal Boolean
     * @param promise Promise
     */
    @ReactMethod
    public void pingPong(Boolean signal, Promise promise) {
        try {
            Log.i("signal", "value input is: " + signal );
            if(!signal) {
                throw new Exception("Signal is false");
            }
            WritableMap data= Arguments.createMap();
            data.putString("signal", "Signal is true");
            promise.resolve(data);
        }catch(Exception e) {
            promise.reject(e);
        }
    }

    /**
     * After register event
     * We trigger this function to do send event back to JavaScript
     * @param count
     * @param eventName
     * @param params
     */
    public void doSendEvent(Integer count, String eventName,@Nullable WritableMap params) {
        do{
            this.sendEvent(this.getReactApplicationContext(), eventName, params);
            count--;
        }while (count > 0);
    }

    /**
     * Send Events to Javascript
     * @param reactContext
     * @param eventName
     * @param params
     */
    private void sendEvent(ReactContext reactContext, String eventName, @Nullable WritableMap params) {
        if (reactContext.hasActiveCatalystInstance()) {
            Log.i("sendEvent", params.toString());
            reactContext
                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit(eventName, params);
        } else {
            Log.i("sendEvent", "Waiting for CatalystInstance...");
        }

    }


}
