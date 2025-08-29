---
date: 2025-08-05T01:53
tags: []
---
[KORA CYBERPUNK STYLING REQUEST

Aplique o tema visual KORA Neural Matrix nas seguintes ferramentas:
- Tmux
- Neovim
- Obsidian CSS
- Terminal (Kitty/Alacritty)

# PALETA DE CORES KORA
## Cores Principais
- Primary Purple: #8B5CF6 (rgb(139, 92, 246))
- Cyan Accent: #8BE9FD (rgb(139, 233, 253))
- Success Green: #50FA7B (rgb(80, 250, 123))
- Warning Yellow: #F1FA8C (rgb(241, 250, 140))
- Error Red: #FF5555 (rgb(255, 85, 85))
- Info Blue: #3B82F6 (rgb(59, 130, 246))

## Backgrounds
- Dark Primary: #0F172A (rgb(15, 23, 42))
- Dark Secondary: #1E293B (rgb(30, 41, 59))
- Surface: #374151 (rgb(55, 65, 81))

## Text Colors
- Primary Text: #E2E8F0 (rgb(226, 232, 240))
- Muted Text: #94A3B8 (rgb(148, 163, 184))
- Bright Text: #F8FAFC (rgb(248, 250, 252))

## Border & Effects
- Border Color: rgba(139, 92, 246, 0.3)
- Glow Effect: 0 0 15px rgba(139, 92, 246, 0.3)
- Gradient: linear-gradient(90deg, #8B5CF6, #8BE9FD)

# VISUAL ELEMENTS STYLE
## Cards/Panels
- Background: rgba(30, 41, 59, 0.9) with backdrop-filter: blur(5px)
- Border: 1px solid rgba(139, 92, 246, 0.3)
- Border-radius: 8px
- Box-shadow: 0 0 15px rgba(139, 92, 246, 0.3)
- Padding: 20px

## Headers
- Font: Orbitron, monospace (se disponível)
- Color: #8BE9FD (cyan)
- Text-shadow: 0 0 10px #8BE9FD
- Border-bottom: 1px solid #374151

## Interactive Elements
- Hover: transform: translateY(-2px) + glow effect
- Active: background: rgba(139, 92, 246, 0.2)
- Focus: border-color: #8BE9FD

## Status Indicators
- Online/Success: #50FA7B with rgba(80, 250, 123, 0.2) background
- Error/Offline: #FF5555 with rgba(255, 85, 85, 0.2) background
- Warning: #F1FA8C with rgba(241, 250, 140, 0.2) background

## Progress Bars
- Background: #374151
- Fill: linear-gradient(90deg, #8B5CF6, #8BE9FD)
- Height: 20-25px
- Border-radius: 10-12px
- Glow: 0 0 10px rgba(139, 92, 246, 0.5)

## Typography
- Primary Font: 'Courier New', monospace
- Heading Font: 'Orbitron', monospace (if available)
- Code Font: 'JetBrains Mono', 'Fira Code', monospace

## Animations
- Pulse: box-shadow glow que expande e contrai
- Hover: translateY(-2px) com transição suave
- Loading: spin ou fade in/out

# DESIGN PRINCIPLES
1. **High Contrast**: Texto claro em fundos escuros
2. **Neon Accents**: Usar purple/cyan para destacar elementos importantes
3. **Glassmorphism**: Fundos semi-transparentes com blur
4. **Monospace Typography**: Fonte monoespaçada para aesthetic hacker
5. **Subtle Glows**: Sombras coloridas para efeito sci-fi
6. **Card-based Layout**: Organizar conteúdo em cards com bordas neon
7. **Consistent Spacing**: 20px padding, 15px gaps, 8px border-radius

# IMPLEMENTATION EXAMPLES
## CSS Classes Pattern
.kora-card { /* card styling */ }
.kora-header { /* header styling */ }
.kora-button { /* button styling */ }
.kora-progress { /* progress bar styling */ }
.kora-status-ok { /* success status */ }
.kora-status-error { /* error status */ }

## Color Usage
- Purple (#8B5CF6): Primary actions, levels, important highlights
- Cyan (#8BE9FD): Headers, titles, secondary actions
- Green (#50FA7B): Success states, completed items, positive values
- Red (#FF5555): Errors, warnings, overdue items
- Yellow (#F1FA8C): Warnings, pending items, energy indicators

# OUTPUT REQUEST
Forneça configurações completas para cada ferramenta solicitada, mantendo:
1. Consistência visual entre todas as ferramentas
2. Usabilidade e legibilidade
3. Efeitos visuais sutis mas marcantes
4. Compatibilidade com a funcionalidade nativa
5. Fácil manutenção e customização](<# 🎨 PROMPT PARA ESTILIZAÇÃO KORA CYBERPUNK

## 🎯 PROMPT PARA APLICAR ESTILO KORA EM QUALQUER FERRAMENTA

```
KORA CYBERPUNK STYLING REQUEST

Aplique o tema visual KORA Neural Matrix nas seguintes ferramentas:
- Tmux
- Neovim
- Obsidian CSS
- Terminal (Kitty/Alacritty)

# PALETA DE CORES KORA
## Cores Principais
- Primary Purple: #8B5CF6 (rgb(139, 92, 246))
- Cyan Accent: #8BE9FD (rgb(139, 233, 253))
- Success Green: #50FA7B (rgb(80, 250, 123))
- Warning Yellow: #F1FA8C (rgb(241, 250, 140))
- Error Red: #FF5555 (rgb(255, 85, 85))
- Info Blue: #3B82F6 (rgb(59, 130, 246))

## Backgrounds
- Dark Primary: #0F172A (rgb(15, 23, 42))
- Dark Secondary: #1E293B (rgb(30, 41, 59))
- Surface: #374151 (rgb(55, 65, 81))

## Text Colors
- Primary Text: #E2E8F0 (rgb(226, 232, 240))
- Muted Text: #94A3B8 (rgb(148, 163, 184))
- Bright Text: #F8FAFC (rgb(248, 250, 252))

## Border & Effects
- Border Color: rgba(139, 92, 246, 0.3)
- Glow Effect: 0 0 15px rgba(139, 92, 246, 0.3)
- Gradient: linear-gradient(90deg, #8B5CF6, #8BE9FD)

# VISUAL ELEMENTS STYLE
## Cards/Panels
- Background: rgba(30, 41, 59, 0.9) with backdrop-filter: blur(5px)
- Border: 1px solid rgba(139, 92, 246, 0.3)
- Border-radius: 8px
- Box-shadow: 0 0 15px rgba(139, 92, 246, 0.3)
- Padding: 20px

## Headers
- Font: Orbitron, monospace (se disponível)
- Color: #8BE9FD (cyan)
- Text-shadow: 0 0 10px #8BE9FD
- Border-bottom: 1px solid #374151

## Interactive Elements
- Hover: transform: translateY(-2px) + glow effect
- Active: background: rgba(139, 92, 246, 0.2)
- Focus: border-color: #8BE9FD

## Status Indicators
- Online/Success: #50FA7B with rgba(80, 250, 123, 0.2) background
- Error/Offline: #FF5555 with rgba(255, 85, 85, 0.2) background
- Warning: #F1FA8C with rgba(241, 250, 140, 0.2) background

## Progress Bars
- Background: #374151
- Fill: linear-gradient(90deg, #8B5CF6, #8BE9FD)
- Height: 20-25px
- Border-radius: 10-12px
- Glow: 0 0 10px rgba(139, 92, 246, 0.5)

## Typography
- Primary Font: 'Courier New', monospace
- Heading Font: 'Orbitron', monospace (if available)
- Code Font: 'JetBrains Mono', 'Fira Code', monospace

## Animations
- Pulse: box-shadow glow que expande e contrai
- Hover: translateY(-2px) com transição suave
- Loading: spin ou fade in/out

# DESIGN PRINCIPLES
1. **High Contrast**: Texto claro em fundos escuros
2. **Neon Accents**: Usar purple/cyan para destacar elementos importantes
3. **Glassmorphism**: Fundos semi-transparentes com blur
4. **Monospace Typography**: Fonte monoespaçada para aesthetic hacker
5. **Subtle Glows**: Sombras coloridas para efeito sci-fi
6. **Card-based Layout**: Organizar conteúdo em cards com bordas neon
7. **Consistent Spacing**: 20px padding, 15px gaps, 8px border-radius

# IMPLEMENTATION EXAMPLES
## CSS Classes Pattern
.kora-card { /* card styling */ }
.kora-header { /* header styling */ }
.kora-button { /* button styling */ }
.kora-progress { /* progress bar styling */ }
.kora-status-ok { /* success status */ }
.kora-status-error { /* error status */ }

## Color Usage
- Purple (#8B5CF6): Primary actions, levels, important highlights
- Cyan (#8BE9FD): Headers, titles, secondary actions
- Green (#50FA7B): Success states, completed items, positive values
- Red (#FF5555): Errors, warnings, overdue items
- Yellow (#F1FA8C): Warnings, pending items, energy indicators

# OUTPUT REQUEST
Forneça configurações completas para cada ferramenta solicitada, mantendo:
1. Consistência visual entre todas as ferramentas
2. Usabilidade e legibilidade
3. Efeitos visuais sutis mas marcantes
4. Compatibilidade com a funcionalidade nativa
5. Fácil manutenção e customização
```

---

## 🛠️ EXEMPLO DE USO DO PROMPT

**Para Tmux:**
```
KORA CYBERPUNK STYLING REQUEST

Aplique o tema visual KORA Neural Matrix no Tmux.
[Cole toda a seção de paleta e estilos acima]

Preciso de:
- Status bar com cores KORA
- Indicadores de pane ativos
- Configuração de janelas
- Efeitos visuais nos separadores
- Integração com Powerline/símbolos
```

**Para Neovim:**
```
KORA CYBERPUNK STYLING REQUEST

Aplique o tema visual KORA Neural Matrix no Neovim.
[Cole toda a seção de paleta e estilos acima]

Preciso de:
- Colorscheme personalizado
- Configuração de plugins (lualine, telescope, nvim-tree)
- Highlights para sintaxe
- UI elements (floating windows, popups)
- LSP diagnostics colors
```

**Para Obsidian:**
```
KORA CYBERPUNK STYLING REQUEST

Aplique o tema visual KORA Neural Matrix no Obsidian.
[Cole toda a seção de paleta e estilos acima]

Preciso de:
- CSS snippet completo
- Styling para notes e markdown
- Sidebar e interface elements
- Callouts e admonitions
- Canvas styling
- Plugin compatibility
```

Quer que eu use esse prompt para gerar as configurações específicas de alguma ferramenta agora?>)