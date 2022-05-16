varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vFragCoord;

uniform vec3 u_uResolution;

void main()
{
    const float K1 = 0.15625;
    const float K2 = 0.0;
    
    vec2 channelCenter0 = vec2(0.0, -0.015625);
    vec2 channelCenter1 = vec2(0.0, 0.015625);
    vec2 channelCenter2 = vec2(0.0, 0.0);
    
    vec2 uv = v_vFragCoord.xy / u_uResolution.xy;
    vec2 uvCenter = uv*2.0 - 1.0;
    
    vec3 color = vec3(0);
    
    // 0
    vec2 d0 = channelCenter0 - uvCenter;
    float d2 = dot(d0, d0);
    float d4 = d2 * d2;
    
    vec2 uv0 = uvCenter / vec2(1.0 + K1 * d2 + K2 * d4);
    color[0] = texture2D(gm_BaseTexture, uv0*0.5 + 0.5)[0];
    
    // 1
    d0 = channelCenter1 - uvCenter;
    d2 = dot(d0, d0);
    d4 = d2 * d2;
    
    vec2 uv1 = uvCenter / vec2(1.0 + K1 * d2 + K2 * d4);
    
    color[1] = texture2D(gm_BaseTexture, uv1*0.5 + 0.5)[1];
    
    // 2
    d0 = channelCenter2 - uvCenter;
    d2 = dot(d0, d0);
    d4 = d2 * d2;
    
    vec2 uv2 = uvCenter / vec2(1.0 + K1 * d2 + K2 * d4);
    color[2] = texture2D(gm_BaseTexture, uv2*0.5 + 0.5)[2];
    
    gl_FragColor = vec4(color, 1);

}