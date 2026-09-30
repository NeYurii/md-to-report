---
mainfont: Liberation Serif
sansfont: Liberation Sans
monofont: Liberation Mono

year: 2026 - 2027

author: NeYurii
group: Group-code
lecturer: Lecturer

specialtycode: 123
subjectname: SUBJECT NAME
subjectacronym: SN

worknumber: 17
listnumber: 4

topic: >
  Тема

objective: >
  Мета

equipment: >
  Обладнання

conclusion: >
  Висновок
---

## Хід роботи

1 Отримати в викладача номер індивідуального варіанта.

Long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text
Long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text long text

2 Реалізувати просту шифруючу таблицю (запис по рядках, читання по стовпцях).

```zig
//! Write by rows, read by cols
const std = @import("std");
const Io = std.Io;
const opts = @import("options.zig");
```

### Результати тестування

![Порядок колонок за ключовим словом](./assets/keyword_order.png)

![Порядок колонок за ключовим словом](./assets/keyword_order.png)

: Дуже довгий опис таблиці Дуже довгий опис таблиці Дуже довгий опис таблиці Дуже довгий опис таблиці

+---------------------+----------+
| Property            | Earth    |
+=============+=======+==========+
|             | min   | -89.2 °C |
| Temperature +-------+----------+
| 1961-1990   | mean  | 14 °C    |
|             +-------+----------+
|             | max   | 56.7 °C  |
+-------------+-------+----------+

: Test table 2

| Heading 1           | Heading 2           | Heading 3               |
| ------------------- | :-----------------: | ----------------------: |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
| This is Contents 1  | This is Contents 2  | This is Contents 3      |
