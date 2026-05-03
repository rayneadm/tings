# 🧠 Neovim (LazyVim) — DevOps конфигурация

Минималистичная и быстрая конфигурация Neovim для DevOps задач.

Поддержка:

- Kubernetes (YAML)
- Docker
- Python
- Terraform
- Ansible

---

## 🚀 Установка на новый ноутбук

### 1. Установить зависимости

```bash
brew install neovim git node python pipx
brew install shfmt
npm install -g prettier
pipx install black
```

---

### 2. Установить конфиг

```bash
git clone <REPO_URL> ~/.config/nvim
```

---

### 3. Первый запуск

```bash
nvim
```

Внутри:

```vim
:Lazy sync
:Mason
```

---

## ⌨️ Горячие клавиши

### Общие

- `<leader>` = пробел
- `<leader>?` — список всех хоткеев

---

### 🔎 Поиск

- `<leader>ff` — найти файл
- `<leader>fg` — поиск по тексту
- `<leader>fb` — буферы
- `<leader>fr` — недавние файлы

---

### 🧭 LSP

- `K` — описание
- `gd` — перейти к определению
- `gr` — найти использования
- `<leader>rn` — переименовать
- `<leader>ca` — исправления

---

### 🧪 Ошибки

- `]d` — следующая ошибка
- `[d` — предыдущая ошибка
- `<leader>xx` — список ошибок

---

### ✏️ Редактирование

- `gcc` — комментарий строки
- `gc` (visual) — комментарий блока

---

### 📦 Буферы

- `<leader>bd` — закрыть буфер
- `<leader>bo` — закрыть остальные

---

### 🧠 Автокомплит

- `Ctrl + Space` — подсказки
- `Enter / Tab` — выбрать
- `Ctrl + e` — закрыть

---

### 💾 Форматирование

- `:w` — сохранить и форматировать

---

## ⚡ Производительность

- Старт: ~30–40ms
- Lazy loading
- Плагины грузятся по требованию

---

## 📌 Примечания

- Node обязателен для LSP
- Python через pipx
- YAML использует Kubernetes schema

---
