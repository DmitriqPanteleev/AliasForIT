//
//  WordsStorage.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 16.11.2022.
//

import Foundation

struct WordsStorage {
    static func getRoundWords(count: Int) -> [String] {
        self.baseWords.shuffled().suffix(count)
    }
    
    static let baseWords = ["Бэклог", "Баг", "БД", "Библиотека", "Внедрение", "Интеграция", "Код", "Константа (Лере не засчитывать)", "Массив", "Модуль", "ООП", "ОС", "Программист", "Процедура", "Разработка", "Рекурсия", "Системный анализ", "Софт", "СУБД", "Тестировщик", "Таск", "Фича", "Функция", "Дейли", "Коммит", "Спринт", "Ветка", "Мок", "Прод", "Спецификация", "Скоуп", "Флоу", "Ревью", "DevOps", "PM", "iOS", "Android", "Backend", "Frontend", "Дизайн-макет", "Оффер", "API", "Cloud Service", "Git", "MVP", "Pull request", "Merge request", "Авторизация", "Архитектура", "Аутентификация", "Бекап", "Компилятор", "Легаси-код", "Микросервисы", "Монолит", "Опенсорс", "Пет-проект", "Паттерн", "Репозиторий", "Сервер", "Стек", "Фаервол", "Фреймворк", "Нагрузочное тестирование", "Регрессионное тестирование", "Код-ревью", "Отладка", "Рефакторинг", "Agile", "Релиз", "Аутсорс", "Аутстаф", "Онбординг", "Бета", "Гит", "Деплой", "Косиыль", "Пуш в дев (только для Ромы)", "Линтер", "Мидл", "Джун", "Софт-скиллы", "Тимлид", "Фикс", "Хотфикс", "Хардкод", "CMS", "Техдолг", "Бенч", "Дамп", "Лог", "Редирект", "Трейни", "Нейросети", "Машинное обучение", "AI", "AR", "Web", "Desktop", "Mobile", "MVC", "MVVM", "Чистая архитектура", "VIPER", "Модель", "ViewModel", "Сокет", "Multithreading", "Breakpoint", "Функциональное программирование", "Кэширование", "Хэш-таблица", "Гексагональная архитектура", "Байт-код", "Ассмеблер", "Коллизия", "Game Dev", "Смоук-тест", "Патч", "Реактивное программирование", "Конструктор", "Инициализация", "Инициализатор", "Куча", "Очередь", "Рекурсия", "Ручное тестирование", "Биллинг", "Domain Model", "Домен", "IDE", "String", "Integer", "Float", "Токен", "Tokenizer", "Кэш", "Asset", "Go", "Closure", "Маппер", "Design System", "ViewGroup", "Anroid Package Kit", "React", "Angular", "View", "Буфер", "Кластер", "Паттерн матчинг", "Монада", "Функтор", "Синхронизация", "Scala", "Lisp", "Touch Screen", "Контейнер", "Composer", "Docker", "PHP", "MVI", "C++", "C#", "Композиция", "Наследование", "Инкапсуляция", "Reboot", "Laravel", "Symfony", "Ruby", "Presentation Layer", "Разработчик", "Состояние гонки", "Дэдлок", "Cocoa", "Stub", "Upgrage", "Синтаксис", "Конфиг", "Hss", "HTML", "CSS", "JavaScript", "Краш", "Fragment", "UI-тест", "Unit-тест", "Livelock", "SVG", "Скролл", "Шардинг", "Char", "Цикл", "Primary key", "Foreign key", "Зеркалирование", "Kafka", "SQL", "Mongo", "Firebase", "Thread", "Дедупликация", "Domain Driven Design", "Broadcact", "Publisher", "Observer", "Stream", "Header", "Coroutine", "Оптимизация", "Шифрование", "Спам", "Криптография", "Директория", "Интерпретатор", "Кластеризация", "Функция", "Аргумент", "Абстракция", "Кросс-валидация", "Валидация", "Монорепозиторий", "Тест-план", "Стек", "Очередь", "Dictionary", "Set", "Vector", "Model Driven Design", "Flutter", "Linker", "Dart", "Kotlin", "Cassandra", "Bitmap", "JIT", "AOT", "Layout", "Скрипт", "VM", "Concurrancy", "CVS", "Бинарный поиск", "Бинарное дерево", "Objective-C", "Singleton", "Manifest", "Ядро", "Профилирование", "Tarantool", "Builder", "RocksDB", "Lambda", "Замыкание", "Анонимная функция", "ATOM", "Селективность", "Регулярное выражение", "Деструктор", "Деинициализатор", "Альфа-тестирование", "Черный ящик", "Белый ящик", "Императивное программирование", "Декларативное программирование", "Модуляризация", "Push", "Консоль", "Прокси", "Верификация", "Асинхронность", "JSON", "Эмулятор", "Негативное тестирование", "PHP", "UI", "Python", "Рендеринг", "Полиморфизм", "Коммит", "Deadline", "REST", "HTTP", "Websocket", "Stack Overflow", "Сортировка", "Сборщик мусора", "Bash", "Testflight", "MySQL", "Процессор", "IPv6", "Request", "Response", "Toolbar", "GitHub", "GitLab", "ОЗУ", "Nginx", "Утечка памяти", "Репликация", "Selenium", "SDK", "Гейзенбаг", "Сниффер", "TDD", "Apium", "Bottleneck", "I/O", "Selenoid", "Intent", "Пиксель перфект", "Переменная", "Балансировщик", "Программист", "Пинг", "Big Data", "Storage", "Сервис", "Автоматизированное тестирование", "Бит", "GPU", "QA", "UX", "Coockie", "Jira", "Android Studio", "Habr", "URL", "Activity", "Билд", "Push-уведомление", "MariaDB", "Локализация", "Серый ящик", "Индекс", "XCode", "Test Case", "Use Case", "Figma"]

}

