package com.example.vh.quicken;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;


import java.util.Arrays;
import java.util.List;
public class FirstActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_first);


        final Context context = this;

        Button uncaughtExceptionButton =(Button) findViewById(R.id.uncaughtException);
        uncaughtExceptionButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                uncaughtExceptionAction(v);
            }
        });

        Button caughtExceptionButton =(Button) findViewById(R.id.caughtException);
        caughtExceptionButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                caughtExceptionAction(v);
            }
        });

        Button reactButton = (Button) findViewById(R.id.reactNativeCrash);
        reactButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(context, MainActivity.class);
                startActivity(intent);
            }
        });
    }

    public void uncaughtExceptionAction(View view)
    {
        throw new RuntimeException("This is a crash");
    }

    public void caughtExceptionAction(View view)
    {
        try
        {
            throw new RuntimeException("This is a crash");
        }
        catch (RuntimeException e) {
            System.out.println("This is a caught crash");
        }
    }
}
