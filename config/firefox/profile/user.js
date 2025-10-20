/******************************************************************************
 * Desempenho e memória
 ******************************************************************************/

// Limite de processos de conteúdo (impacta RAM). 4 é um bom teto <~4 GB em uso pesado.
user_pref("dom.ipc.processCount", 4);
user_pref("dom.ipc.processCount.webIsolated", 4);

// Evita pré-lançamento de processos que ficam parados ocupando RAM.
user_pref("dom.ipc.processPrelaunch.enabled", false);

// Descarregar abas sob pressão de memória (nativo).
user_pref("browser.tabs.unloadOnLowMemory", true);

// Reduz preload da nova aba para economizar RAM.
user_pref("browser.newtab.preload", false);

// Cache em memória controlado (KB). 256 MB equilibrado.
user_pref("browser.cache.memory.enable", true);
user_pref("browser.cache.memory.capacity", 262144);

// Cache em disco ligado com limite sensato (KB). 1 GB melhora responsividade.
user_pref("browser.cache.disk.enable", true);
user_pref("browser.cache.disk.capacity", 1048576);

/******************************************************************************
 * Gráfico/AMD/Wayland
 ******************************************************************************/

// WebRender e DMA-BUF forçados (Wayland). Melhora uso de GPU no AMD.
user_pref("gfx.webrender.all", true);
user_pref("widget.dmabuf.force-enabled", true);

// Decodificação de vídeo por VA-API.
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.hardware-video-decoding.enabled", true);

// QUIC/HTTP3 para latência menor.
user_pref("network.http.http3.enabled", true);

/******************************************************************************
 * Rede prefetch/reuse (mantendo velocidade)
 ******************************************************************************/

user_pref("network.predictor.enabled", true);
user_pref("network.prefetch-next", true);
user_pref("network.dns.disablePrefetch", false);

/******************************************************************************
 * UI compacta e sem animações caras
 ******************************************************************************/

user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);                 // 0 normal, 1 compacto
user_pref("toolkit.cosmeticAnimations.enabled", false);
user_pref("ui.prefersReducedMotion", 1);

/******************************************************************************
 * Limpeza: desliga serviços pesados
 ******************************************************************************/

user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);

/******************************************************************************
 * Qualidade de vida
 ******************************************************************************/

// Copiar com Ctrl+L, etc., sem pop-ups “Firefox View”.
user_pref("browser.tabs.firefox-view", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
