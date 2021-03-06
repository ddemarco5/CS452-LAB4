#version 130


uniform vec4 Ambient;

uniform vec3 LightColor1;
uniform vec3 LightDirection1;
uniform vec3 HalfVector1;

uniform vec3 LightColor2;
uniform vec3 LightDirection2;
uniform vec3 HalfVector2;

in vec4 pass_color;
in vec3 normal;

out vec4 out_color;

void main(){
  vec3 amb = vec3(Ambient);


  float diffuse1 = max(0.0, dot(normal, normalize(LightDirection1)));
  float specular1 = max(0.0, dot(normal, normalize(HalfVector1)));
  float diffuse2 = max(0.0, dot(normal, normalize(LightDirection2)));
  float specular2 = max(0.0, dot(normal, normalize(HalfVector2)));

  if (diffuse1 == 0.0)
      specular1 = 0.0;
  else
      specular1 = pow(specular1, 7);
  if (diffuse2 == 0.0)
      specular2 = 0.0;
  else specular2 = pow(specular2, 5);

  vec3 scatteredLight = Ambient.rgb + LightColor1 * diffuse1 + LightColor2 * diffuse2;
  vec3 reflectedLight = LightColor1 * specular1 * 20;
  vec3 reflectedLight2 = LightColor2 * specular2 * 5;

  vec3 rgb = min( (pass_color.rgb * amb) * scatteredLight + reflectedLight + reflectedLight2, vec3(1.0));

  out_color = vec4(rgb, pass_color.a);
}