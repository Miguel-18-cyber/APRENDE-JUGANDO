const challenges = [
  { world: '🔢　PLANETA NUMÉRICO', question: '¿Cuánto es 6 + 3?', options: ['8', '9', '10', '12'], answer: '9' },
  { world: '🔤　ISLA DE LAS LETRAS', question: '¿Con qué letra empieza “sol”?', options: ['S', 'L', 'M', 'A'], answer: 'S' },
  { world: '🎨　JARDÍN DE COLORES', question: '¿Qué color sigue? 🔵 🟣 🔵 🟣 …', options: ['🟢', '🔵', '🟡', '🔴'], answer: '🔵' },
];
const progressKey = 'aprende-jugando-web-xp-v1';
let xp = Number(localStorage.getItem(progressKey) || 0);
let round = 0;
let locked = false;
const answerGrid = document.querySelector('#answer-grid');
const feedback = document.querySelector('#quiz-feedback');

function renderChallenge() {
  const challenge = challenges[round];
  document.querySelector('#quiz-world').textContent = challenge.world;
  document.querySelector('#quiz-question').textContent = challenge.question;
  document.querySelector('#quiz-step').textContent = `${String(round + 1).padStart(2, '0')} / 03`;
  document.querySelector('#quiz-progress').style.width = `${((round + 1) / 3) * 100}%`;
  document.querySelector('#quiz-round-label').textContent = `Ronda ${round + 1} de 3`;
  feedback.textContent = 'Elige una respuesta para continuar';
  feedback.className = 'quiz-feedback';
  answerGrid.replaceChildren(...challenge.options.map((option) => {
    const button = document.createElement('button');
    button.className = 'answer-option';
    button.type = 'button';
    button.textContent = option;
    button.addEventListener('click', () => chooseAnswer(button, option, challenge.answer));
    return button;
  }));
  locked = false;
}

function chooseAnswer(button, selection, answer) {
  if (locked) return;
  locked = true;
  const correct = selection === answer;
  answerGrid.querySelectorAll('button').forEach((item) => {
    item.disabled = true;
    if (item.textContent === answer) item.classList.add('correct');
  });
  if (correct) {
    xp += 10;
    localStorage.setItem(progressKey, String(xp));
    document.querySelector('#quiz-xp').textContent = `${xp} XP`;
    feedback.textContent = '¡Muy bien! Sumaste 10 XP. Siguiente reto…';
    feedback.className = 'quiz-feedback good';
  } else {
    button.classList.add('incorrect');
    feedback.textContent = '¡Buen intento! Mira la respuesta y prueba otro reto.';
    feedback.className = 'quiz-feedback bad';
  }
  window.setTimeout(() => {
    round = (round + 1) % challenges.length;
    renderChallenge();
  }, 1300);
}

document.querySelector('#quiz-xp').textContent = `${xp} XP`;
renderChallenge();
document.querySelector('#year').textContent = new Date().getFullYear();

const menuButton = document.querySelector('.menu-toggle');
const nav = document.querySelector('.nav-links');
menuButton.addEventListener('click', () => {
  const open = nav.classList.toggle('open');
  menuButton.setAttribute('aria-expanded', String(open));
  menuButton.setAttribute('aria-label', open ? 'Cerrar menú' : 'Abrir menú');
});
nav.querySelectorAll('a').forEach((link) => link.addEventListener('click', () => {
  nav.classList.remove('open');
  menuButton.setAttribute('aria-expanded', 'false');
}));
