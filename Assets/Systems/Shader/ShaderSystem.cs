using Assets.SystemBase;
using Assets.Utils;
using System.Collections.Generic;
using UniRx;
using UniRx.Triggers;
using UnityEngine;

namespace Assets.Systems.Shader
{
    public class ShaderSystem : GameSystem<ShaderImageComponent>
    {
        private Texture2D _inputTexture;
        private RenderTexture _outputTexture;
        private Material _shader;

        public override int Priority
        {
            get { return 1; }
        }

        public override void Init()
        {
            _inputTexture = new Texture2D(400, 400);
            _outputTexture = new RenderTexture(400, 400, 0, RenderTextureFormat.Default, RenderTextureReadWrite.sRGB);
            _shader = new Material(UnityEngine.Shader.Find("Hidden/Colors"));
        }

        public override void Register(ShaderImageComponent component)
        {
            component.GetComponent<Renderer>().material.mainTexture = _outputTexture;

            IoC.Resolve<Game>().UpdateAsObservable().Subscribe(Update);
        }

        private void Update(Unit unit)
        {
            //_shader.SetFloatArray("size", new float[]{ 400, 400 });
            _shader.SetFloat("u_time", Time.realtimeSinceStartup);
            Graphics.Blit(_inputTexture, _outputTexture, _shader);
        }
    }
}
