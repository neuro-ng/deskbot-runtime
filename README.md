# Deskbot Runtime Image

[![Build and Publish Deskbot Runtime Docker Image](https://github.com/neuro-ng/deskbot-runtime/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/neuro-ng/deskbot-runtime/actions/workflows/docker-publish.yml)
[![Docker Image](https://ghcr-badge.egpl.dev/neuro-ng/deskbot-runtime/latest_tag?trim=major&label=latest)](https://github.com/neuro-ng/deskbot-runtime/pkgs/container/deskbot-runtime)

A comprehensive Docker image that provides the full runtime environment for Deskbot, complete with a virtual desktop, accessibility features, and required applications.

## 🐳 This Docker Image

This image is designed to run the Deskbot agent in an isolated, fully equipped environment. Perfect for:

* **Running Deskbot** with a pre-configured graphical environment
* **Automated testing** of GUI interactions
* **Consistent execution environments** across deployments

### What's Included

- **Base**: `ubuntu:22.04`
- **Desktop Environment**: `Xvfb` (Virtual Framebuffer), `XFCE4`, and system X11 utilities (`x11-utils`)
- **Remote Access**: `x11vnc`, `novnc`, and `websockify` for viewing the virtual desktop in a browser
- **Input & Accessibility**: `xdotool`, `xclip`, `at-spi2-core`, and `libatk-adaptor` for GUI interaction and introspection used by `deskbot-executor` and `deskbot-core`
- **Applications**: `libreoffice` and Google Chrome (`google-chrome-stable`)
- **Cloud Tools**: Google Cloud CLI (`google-cloud-cli`)
- **Process Management**: `supervisor` and `gosu` for clean service management and privilege dropping

## 🚀 Quick Start

### Pull and Run
```bash
# Pull the latest image
docker pull ghcr.io/neuro-ng/deskbot-runtime:latest

# Run the runtime image
docker run -it --rm ghcr.io/neuro-ng/deskbot-runtime:latest
```

## 🏗️ Building Locally

If you want to build this Docker image locally:

```bash
git clone https://github.com/neuro-ng/deskbot-runtime.git
cd deskbot-runtime

# Build the image
docker build -t local/deskbot-runtime:latest .

# Run the local image
docker run -it --rm local/deskbot-runtime:latest
```

## 📚 Resources

* See the deeper architectural details in [deskbot/README.md](deskbot/README.md)
* Learn about the multi-phase deployment in [deskbot/roadmap.md](deskbot/roadmap.md)

## 📄 License

Apache 2.0 — see [deskbot/LICENSE](deskbot/LICENSE) for details.
