using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal
{
    /// <summary>Supplies captured lighting parameters only. URP owns targets, camera inputs and draws.</summary>
    public interface IEID3336URPDeferredLightingProvider
    {
        bool TryPrepareEID3336Lighting(Camera camera, out Material material);
    }

    public static class EID3336LightingParameters
    {
        static readonly List<IEID3336URPDeferredLightingProvider> s_Providers =
            new List<IEID3336URPDeferredLightingProvider>();

        public static void Register(IEID3336URPDeferredLightingProvider provider)
        {
            if (provider != null && !s_Providers.Contains(provider)) s_Providers.Add(provider);
        }

        public static void Unregister(IEID3336URPDeferredLightingProvider provider)
        {
            s_Providers.Remove(provider);
        }

        internal static bool TryPrepare(Camera camera, out Material material)
        {
            material = null;
            foreach (var provider in s_Providers)
            {
                if (provider is Object obj && obj == null) continue;
                if (provider.TryPrepareEID3336Lighting(camera, out material)) return true;
            }
            return false;
        }
    }
}
