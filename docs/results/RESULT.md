# Целевая платформа

- Основная разработка велась на Android 10, Xiaomi Mi9T
- Адаптирован под Mac OS > 12 и Web 

# Результаты
Сссылка на демонстрацию: https://youtu.be/jtPsBG1TASw

### Задание 1

Реализовал интерфейс экрана с магическим шаром, добавил экран настроек
![image](https://github.com/AldarKose-dev/surf-flutter-study-jam-4/assets/78011086/e1d78c6d-5325-4a1e-95d4-5848a78a2435)
![image](https://github.com/AldarKose-dev/surf-flutter-study-jam-4/assets/78011086/19623b59-3344-4433-9a7a-846d8e94d267)

### Задание 2

Реализовал функционал нажатия на шар для получения ответа. 

### Задание 3

Добавлена логика работы с API. При правильном запросе текст отображается внутри
логику для обработки пользовательского вопроса и получения ответа от API. В случае ошибки показывается красная подсветка и сообщение об ошибке 

![document_5334919748993953755](https://github.com/AldarKose-dev/surf-flutter-study-jam-4/assets/78011086/d4991de8-0cda-46b6-b961-c5fa3f2ef891)

### Задание 4

Приложение отправляет запрос при тряске телефона
Если не распознал тряску:
- ![image](https://github.com/AldarKose-dev/surf-flutter-study-jam-4/assets/78011086/8c94ab24-9fa4-4ad2-85be-2e84231cabf6)


### Задание 5

Адаптирован под MacOs Web так же работает на IPad но не успел прописать выбор музыки с памяти на ios

### Задание 6
Добавил две анимации
- при обычном состоянии шар парить вверх-вниз
- ![document_5334919748993953754](https://github.com/AldarKose-dev/surf-flutter-study-jam-4/assets/78011086/bffd9874-c66b-42c8-b4f8-7a3028f8ac58)
- при выполнении запроса шар пульсирует светом внутри
- ![document_5334919748993953750](https://github.com/AldarKose-dev/surf-flutter-study-jam-4/assets/78011086/ad77c141-034f-4759-9821-2700fcfa7371)


### Задание 7

Добавлен экран настроек, есть функционал смены скорость анимации шара в спокойном положении. Выключения перевода текста в речь, выключения музыки при запросе и выбор музыки с памяти


### Задание 8

При выдаче ответа/ошибки можете есть аудио-эффект.(Самое долгое было выбрать музыку XD)

Есть возможность выключения звука.

Есть возможность выбора звука с устройства.


### Задание 9

Есть функционал преобразования текста в речь с использованием flutter_tts

Можно включить/отключить эту функцию в настройках. 

### Задание 10

Анимировал текста внутри шара есть выбор разных анимации из экрана настроек, (Fade, Type, Scale, Typewriter)

## Что можно было бы улучшить
- Сделать шар более красивым и нарисовать его реалистичнее а не image как я сделал 😎
- Добавить больше аниации как та же тень или параллакс
## Чему я научился
- Участие в Study Jam стало для меня дополнительным стимулом к саморазвитию и улучшению своих навыков.
  Когда перед тобой задача и очень короткое время выполнения то узнаешь много пробелов в своих знаниях, как те же анимации которые у меня получились не совсем как я хотел, и это мотивирует чтобы продолжать развиваться как специалист!

# Огромная благодарность Surf и особенно автору задачи, идея огонь!🔥

### Используемый стек
  - flutter_bloc: - кубит как основной стейт менеджер
  - dio: - сетевые запросы
  - shake: - shake handling  
  - flutter_tts: text to speech
  - just_audio: проигрывание музыки
  - animated_text_kit: анимации текста
  - file_picker: выбор музыки

Сссылка на демонстрацию: https://youtu.be/jtPsBG1TASw
