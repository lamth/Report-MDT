# Tìm hiểu về SDN và OpenvSwitch.
## 1. Giới thiệu về SDN.
SDN hay điều khiển mạng bằng phần mềm(Software Define Network) được dựa trên cơ chế tách riêng việc kiểm soát luồng mạng(control plane) với luồng dữ liệu (data plane). SDN dựa trên giao thức luồng mở(Open Flow). SDN tách định tuyến và chuyển các luồng dữ liệu riêng rẽ, chuyển chức năng kiểm soát luồng sang phần mạng riêng được gọi là Flow controller. Điều này cho phép các gói dữ liệu đi qua mạng được kiểm soát theo lập trình. Trong SDN, control plane được chuyển từ các thiết bị vật lý sang thiết bị điều khiển luồng.

![](https://i.imgur.com/hBxWgjk.png)

Bộ điều khiển có thể nhìn thấy toàn bộ mạng mà nó quản lý, cho phép dễ dàng tối ưu hệ thống. Bộ điều khiển tương tác với các thiết bị mạng vật lý thông qua một giao thức chuẩn là OpenFlow. Kiến trúc của SDN gồm 3 phần: lớp ứng dụng, lớp điều khiển và lớp cơ sở hạ tầng.

![](https://i.imgur.com/EYy0PlJ.png)

- Lớp ứng dụng: Là các ứng dụng kinh doanh được triển khai trên mạng, được kết nối tới lớp điều khiển thông qua các API, cung cấp khả năng cho phép lớp ứng dụng lập trình lại (cấu hình lại) mạng (điều chỉnh các tham số trễ, băng thông, định tuyến, …) thông qua lớp điều khiển.
- Lớp điều khiển: Là nơi tập trung các bộ điều khiển thực hiện việc điều khiển cấu hình mạng theo các yêu cầu từ lớp ứng dụng và khả năng của mạng. Các bộ điều khiển này có thể là các phần mềm được lập trình.
- Lớp cơ sở hạ tầng: Là các thiết bị mạng thực tế (vật lý hay ảo hóa) thực hiện việc chuyển tiếp gói tin theo sự điều khiển của lớp điểu khiển. Một thiết bị mạng có thể hoạt động theo sự điều khiển của nhiều bộ điều khiển khác nhau, điều này giúp tăng cường khả năng ảo hóa của mạng.


## 2. Open Flow:
OpenFlow là tiêu chuẩn đầu tiên, cung cấp khả năng truyền thông giữa các giao diện của lớp điều khiển và lớp chuyển tiếp trong kiến trúc SDN. OpenFlow cho phép truy cập trực tiếp và điều khiển mặt phẳng chuyển tiếp của các thiết bị mạng như router và switch, cả thiết bị vật lý cũng như thiết bị ảo do đó coa thể di chuyển phần điều khiển mạng từ các thiết bị đến thiết bị điều khiển trung tâm.

- Một thiết bị OpenFlow bao gồm ít nhất 3 thành phần:

    - Secure Channel: kênh kết nối thiết bị tới bộ điều khiển (controller), cho phép các lệnh và các gói tin được gửi giữa bộ điều khiển và thiết bị.
    - OpenFlow Protocol: giao thức cung cấp phương thức tiêu chuẩn và mở cho một bộ điều khiển truyền thông với thiết bị.
    - Flow Table: một liên kết hành động với mỗi luồng, giúp thiết bị xử lý các luồng thế nào. 

    ![](https://i.imgur.com/ahj5KCV.png)

## 3. Open vSwitch
OpenvSwitch (OVS) là một dự án về chuyển mạng đa lớp ảo (multilayer). Mục đích chính của OVS là cung cấp lớp chuyể mạnh cho môi trường ảo hóa phần cứng. 

























Tài liệu:
https://viblo.asia/p/tong-quan-ve-sdn-va-openvswitch-m68Z0N865kG