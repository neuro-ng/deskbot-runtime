# syntax=docker/dockerfile:1

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# ── Desktop environment, accessibility, and whitelisted applications ──────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Virtual desktop
    xvfb \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    # VNC + noVNC web viewer
    x11vnc \
    novnc \
    websockify \
    # Display readiness probe (xdpyinfo) and misc X utilities
    x11-utils \
    # Input simulation — used by deskbot-executor
    xdotool \
    xclip \
    # Documents / spreadsheets
    libreoffice \
    # Accessibility bus (AT-SPI2) — used by deskbot-core
    at-spi2-core \
    libatk-adaptor \
    # Process supervisor
    supervisor \
    # gosu — minimal privilege-drop tool; used in entrypoint.sh to switch from
    # root (needed for chown at container startup) to the deskbot user before
    # exec-ing supervisord.  Preferred over `su` because it replaces the process
    # image cleanly, giving supervisord PID 1 as the non-root user.
    gosu \
    # Misc
    curl \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# ── Google Chrome Stable ──────────────────────────────────────────────────────
# Ubuntu 22.04 ships Chromium as a snap (unavailable inside Docker).
# Google Chrome Stable provides an equivalent .deb package.
RUN curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
      | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] \
             http://dl.google.com/linux/chrome/deb/ stable main" \
         > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# ── Google Cloud CLI ──────────────────────────────────────────────────────────
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-cloud-cli \
    && rm -rf /var/lib/apt/lists/*
