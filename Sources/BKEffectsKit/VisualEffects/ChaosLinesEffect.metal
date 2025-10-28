//
//  ChaosLinesEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/17/25.
//

#include <metal_stdlib>
using namespace metal;

float hash( float n ) {
    return fract(sin(n)*753.5453123);
}

float noise(vector_float2 x )
{
    vector_float2 p = floor(x);
    vector_float2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    
    float n = p.x + p.y*157.0;
    return mix(
               mix( hash(n+  0.0), hash(n+  1.0),f.x),
               mix( hash(n+157.0), hash(n+158.0),f.x),
               f.y);
}


float fbm(vector_float2 p, vector_float3 a)
{
    float v = 0.0;
    v += noise(p*a.x)*0.50 ;
    v += noise(p*a.y)*1.50 ;
    v += noise(p*a.z)*0.125 * 0.1;
    return v;
}


vector_float3 drawLines(
                        vector_float2 uv,
                        vector_float3 fbmOffset,
                        vector_float3 color1,
                        vector_float3 colorSet[4],
                        float secs
                        )
{
    float timeVal = secs * 0.1;
    vector_float3 finalColor = vector_float3( 0.0 );
    vector_float3 colorSets[4] = {
        vector_float3(0.85, 0.46, 0.34),
        vector_float3(0.75, 0.36, 0.24),
        vector_float3(0.65, 0.26, 0.14),
        vector_float3(0.55, 0.16, 0.04)
    };
    
    for( int i=0; i < 4; ++i )
    {

        float indexAsFloat = float(i);
        float amp = 80.0 + (indexAsFloat*0.0);
        float period = 2.0 + (indexAsFloat+2.0);
        float thickness = mix( 0.4, 0.2, noise(uv*2.0) );
        
        float t = abs( 1. /(sin(uv.y + fbm( uv + timeVal * period, fbmOffset )) * amp) * thickness );
        
        finalColor +=  t * colorSets[i];
    }

    
    for( int i=0; i < 4; ++i )
    {
  
        float indexAsFloat = float(i);
        float amp = 40.0 + (indexAsFloat*5.0);
        float period = 9.0 + (indexAsFloat+2.0);
        float thickness = mix( 0.1, 0.1, noise(uv * 12.0) );
        
        float t = abs( 1. /(sin(uv.y + fbm( uv + timeVal * period, fbmOffset )) * amp) * thickness );
        
        finalColor +=  t * colorSets[i] * color1;
    }
    
    return finalColor;
}


[[ stitchable ]] half4 timeLines(
 float2 position,
 half4 color,
 float4 bounds,
 float secs,
 float tapValue
 ) {
     
     vector_float2 uv = ( position / bounds.w ) * 1.0 - 1.0;
     uv *= 1.0 + 0.5;

     
     vector_float3 lineColor1 = vector_float3( 218/255, 119/255, 87/255 );
     vector_float3 lineColor2 = vector_float3( 218/255, 119/255, 87/255 );
     
     float spread = abs(tapValue);
     vector_float3 finalColor = vector_float3(218/255, 119/255, 87/255);
     vector_float3 colorSet[4] = {
         vector_float3(218/255, 119/255, 87/255),
         vector_float3(218/255, 119/255, 87/255),
         vector_float3(218/255, 119/255, 87/255),
         vector_float3(218/255, 119/255, 87/255)
     };
     
     float t = sin( secs ) * 0.5 + 0.5;
     float pulse = mix( 0.05, 0.20, t);

     
     finalColor = drawLines(uv, vector_float3( 65.2, 40.0, 4.0), lineColor1, colorSet, secs * 0.2) * pulse;
     finalColor += drawLines( uv, vector_float3( 5.0 * spread/2, 2.1 * spread, 1.0), lineColor2, colorSet, secs );
     
     return half4(half3(finalColor), 1.0);
     
 }
