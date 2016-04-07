## Голосовые файлы

### Зависимости

* Make
* ffpmpeg (с поддержкой libopencore_amrnb)

### Конвертирование

    make

### Выгрузка на сервер обновления

    make upload

### Настройка:

Настройка битрейта находится в файле "Makefile", сторка 


```
#!python

FFMPEG_FLAGS := -acodec libopencore_amrnb -ab 1.8k -ac 1 -ar 8k -y $(FFMPEG_GAIN_$(LANG))
```

	
Примечание: Для старых GSM модулей использовать сжатие 12.2k

	
Настройка языка: 


```
#!python

LANG := vi_VN
```
 (нужно раскомментировать требуемую строку)