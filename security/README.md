# KORA Security Protocol

Este documento fornece diretrizes essenciais para proteger seu ambiente de desenvolvimento.

## 1. Firewall (UFW)

O `ufw` (Uncomplicated Firewall) já foi instalado e ativado com um conjunto de regras padrão seguras durante a instalação.

- **Status:** `sudo ufw status verbose`
- **Regras Padrão:** Nega todas as conexões de entrada, permite todas as de saída.
- **Habilitar uma porta (ex: SSH):** `sudo ufw allow ssh` ou `sudo ufw allow 22/tcp`
- **Desabilitar:** `sudo ufw disable`

## 2. VPN (Virtual Private Network)

Usar uma VPN é crucial para proteger sua privacidade e segurança em redes não confiáveis (Wi-Fi público, etc.).

### Opção A: ProtonVPN (Foco em Privacidade)

Oferece um plano gratuito generoso e tem um CLI oficial para Linux.

1.  **Instalação:** `yay -S protonvpn-cli`
2.  **Login:** `protonvpn-cli login <seu_usuario>`
3.  **Conectar:** `protonvpn-cli connect --fastest` (conecta ao servidor mais rápido)
4.  **Desconectar:** `protonvpn-cli disconnect`

### Opção B: Tailscale (Redes Pessoais Seguras)

Excelente para criar uma rede segura entre seus próprios dispositivos (PC, laptop, servidor na nuvem) como se estivessem na mesma sala. É gratuito para uso pessoal.

1.  **Instalação:** `yay -S tailscale`
2.  **Ativar Serviço:** `sudo systemctl enable --now tailscaled`
3.  **Autenticar:** `sudo tailscale up` (siga o link para fazer login)

Use Tailscale para acessar seus dispositivos de forma segura e ProtonVPN para privacidade geral na internet.

## 3. Boas Práticas Adicionais

- **Mantenha o sistema atualizado:** Execute `sudo pacman -Syu` regularmente.
- **Use um gerenciador de senhas:** Bitwarden, 1Password, etc.
- **SSH Keys:** Sempre prefira autenticação por chave SSH em vez de senhas.
- **Backup:** Faça backup regularmente dos seus dotfiles e dados importantes.
