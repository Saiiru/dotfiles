// Templater User Script: Atualiza xp_today e tasks_completed no Daily atual.
// Lógica: soma XP só das tasks concluídas nesta nota.
// Tokens suportados (somados se aparecerem juntos):
// - [xp:N] → override (se presente, substitui o cálculo)
// - [study:Xm]  → 0.4 XP/min
// - [mobility:Xm] → 0.3 XP/min
// - [relax:Xm] → 0.25 XP/min
// - [strength:session] → +20
// - [parkour:skill] → +12
// - [shoulder:session] → +10
// - [breath:session] → +6
module.exports = async (tp) => {
  const file = tp.file.find_tfile(tp.file.path);
  if (!file) { new Notice("Daily XP: arquivo não encontrado."); return; }
  let content = await app.vault.read(file);

  const fmMatch = content.match(/^---\s*[\s\S]*?---/);
  const body = content.replace(/^---\s*[\s\S]*?---\n?/, "");

  const lines = body.split(/\r?\n/);
  // Apenas tasks concluídas
  const doneTaskRe = /^\s*[-*]\s*\[[xX]\]\s*(.+)$/;
  const mins = (text, tag) => {
    const m = text.match(new RegExp(`\\[${tag}:(\\d+)m\\]`, "i"));
    return m ? parseInt(m[1], 10) : 0;
  };
  const has = (text, tag) => new RegExp(`\\[${tag}\\]`, "i").test(text);
  const hasWord = (text, token) => new RegExp(`\\[${token}:session\\]`, "i").test(text);

  let tasksCompleted = 0;
  let xpTotal = 0;

  for (const line of lines) {
    const m = line.match(doneTaskRe);
    if (!m) continue;
    tasksCompleted += 1;
    const text = m[1];

    // Override explícito
    const xpM = text.match(/\[xp:(\d+)\]/i);
    if (xpM) { xpTotal += parseInt(xpM[1], 10); continue; }

    // Tokens por minuto
    xpTotal += Math.round(mins(text, "study") * 0.4);
    xpTotal += Math.round(mins(text, "mobility") * 0.3);
    xpTotal += Math.round(mins(text, "relax") * 0.25);

    // Sessões fixas
    if (hasWord(text, "strength")) xpTotal += 20;
    if (hasWord(text, "parkour")) xpTotal += 12;
    if (hasWord(text, "shoulder")) xpTotal += 10;
    if (hasWord(text, "breath")) xpTotal += 6;
  }

  // Atualiza frontmatter
  let fm = fmMatch ? fmMatch[0] : "---\n---";
  const setFm = (key, val) => {
    if (new RegExp(`^${key}:`, "m").test(fm)) {
      fm = fm.replace(new RegExp(`^(${key}:\\s*).*$`, "m"), `$1${val}`);
    } else {
      fm = fm.replace(/---\s*$/, `${key}: ${val}\n---`);
    }
  };
  setFm("xp_today", xpTotal);
  setFm("tasks_completed", tasksCompleted);

  const newContent = fm + "\n" + body;
  await app.vault.modify(file, newContent);
  new Notice(`Daily XP atualizado: XP=${xpTotal} • Tasks=${tasksCompleted}`, 3000);
};