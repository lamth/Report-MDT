[LabelImg](https://github.com/tzutalin/labelImg)
========

## Cài đặt
------------------

### Ubuntu
```bash
pip3 install labelImg
labelImg
```

### Windows

Cài đặt thư viện yêu cầu `Python <https://www.python.org/downloads/windows/>`__,
`PyQt5 <https://www.riverbankcomputing.com/software/pyqt/download5>`__
và `lxml <http://lxml.de/installation.html>`__.

```bash
conda install pyqt=5
conda install -c anaconda lxml
pyrcc5 -o libs/resources.py resources.qrc
python labelImg.py
```

## Gán nhãn
------------------

1. Chọn chuột vào nút **PascalVOC** để chuyển sang chế độ **YOLO**.
![1](https://i.imgur.com/TVUdVy0.png)
2. Chọn **Open Dir** để mở thư mục chứa dữ liệu ảnh.
![2](https://i.imgur.com/lbV2asX.png)
3. Bấm phím **W** để tạo box vẽ khung bao quanh *người* và gán nhãn là **person**. Ctrl+S để lưu.
![1](https://i.imgur.com/zFxaYOS.png)
![1](https://i.imgur.com/zkhGO2I.png)
![1](https://i.imgur.com/j9rrGTi.png)

Lưu ý:

- Box có thể kéo thả tuỳ ý.
- Chú ý các hotkeys để làm cho nhanh.

~~~~~~~~~~~~~~~~~~~~~~~~
Hotkeys
~~~~~~~
+--------------------+--------------------------------------------+
| Ctrl + s           | Save                                       |
+--------------------+--------------------------------------------+
| Ctrl + d           | Nhẫn bản box và nhãn của 1 box             |
+--------------------+--------------------------------------------+
| Ctrl + Shift + d   | Xoá ảnh hiện tại                           |
+--------------------+--------------------------------------------+
+--------------------+--------------------------------------------+
| w                  | Tạo box                                    |
+--------------------+--------------------------------------------+
| d                  | Chuyển ảnh tiếp theo                       |
+--------------------+--------------------------------------------+
| a                  | Chuyển ảnh trước đó                        |
+--------------------+--------------------------------------------+
| del                | Xoá box                                    |
+--------------------+--------------------------------------------+


> Written with [StackEdit](https://stackedit.io/).
