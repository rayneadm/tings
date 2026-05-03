# 💤 LazyVim - — DevOps конфигурация

Ниже — чистый, lint-friendly README.md, без ошибок markdownlint (MD025, MD012, MD040 исправлены).

Можно копировать как есть 👇

⸻

:::writing{variant=“standard” id=“84219”}

🧠 Neovim (LazyVim) — DevOps конфигурация

Минималистичная и быстрая конфигурация Neovim с поддержкой:
• Kubernetes (YAML)
• Docker
• Python
• Terraform
• Ansible

⸻

🚀 Установка на новый ноутбук

1. Установить зависимости

Основные

brew install neovim git node python pipx

Дополнительные инструменты

brew install shfmt
npm install -g prettier
pipx install black

⸻

1. Установить конфиг

git clone <REPO_URL> ~/.config/nvim

⸻

1. Первый запуск

nvim

Внутри Neovim:

:Lazy sync
:Mason

⸻

🧰 Что установлено

LSP (подсказки и диагностика)
• lua_ls
• bashls
• jsonls
• yamlls (с Kubernetes schema)
• pyright
• dockerls
• terraformls
• ansiblels

⸻

Форматирование
• prettier → YAML / JSON
• black → Python
• shfmt → bash

⸻

⌨️ Горячие клавиши

Общие

Клавиша Действие
<leader> пробел
<leader>? показать все хоткеи

⸻

🔎 Поиск

Клавиша Действие
<leader>ff найти файл
<leader>fg поиск по тексту
<leader>fb список буферов
<leader>fr недавние файлы

⸻

🧭 LSP

Клавиша Действие
K описание
gd перейти к определению
gr найти использования
<leader>rn переименовать
<leader>ca исправления

⸻

🧪 Ошибки

Клавиша Действие
]d следующая ошибка
[d предыдущая ошибка
<leader>xx список ошибок

⸻

✏️ Редактирование

Клавиша Действие
gcc закомментировать строку
gc закомментировать выделение

⸻

📦 Буферы

Клавиша Действие
<leader>bd закрыть буфер
<leader>bo закрыть остальные

⸻

🧠 Автокомплит

Клавиша Действие
Ctrl + Space открыть список
Enter / Tab выбрать
Ctrl + e закрыть

⸻

💾 Форматирование

Клавиша Действие
:w сохранить + форматировать

⸻

🧪 Пример работы 1. Найти файл:

<leader>ff

    2. Найти строку:

<leader>fg

    3. Перейти к ошибке:

]d

    4. Посмотреть описание:

K

    5. Исправить:

<leader>ca

    6. Сохранить:

:w

⸻

⚡ Производительность
• Старт: ~30–40 ms
• Lazy loading
• Загружаются только нужные плагины

⸻

📌 Примечания
• LSP требует установленный node
• Python инструменты ставятся через pipx
• YAML использует Kubernetes schema

⸻

🧠 Итог

Конфигурация даёт:
• удобную навигацию по коду
• автокомплит и диагностику
• быстрый поиск
• минимализм и скорость
• удобство для DevOps задач
:::

⸻

Если нужно — можно отдельно сделать:
• install.sh (одной командой всё поднимает)
• dotfiles-репозиторий с автоконфигом
