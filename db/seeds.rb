# 1=> Nhóm, 2=> Origin, 3=> status, 4=> Tuong tac, 5=>Folder
# groups = [
#   {label: 1, name: 'Khách lẻ', intro: 'Khách mới', can_modify: false, can_delete: false},
#   {label: 1, name: 'Khách thân thiết', intro: 'Khách hàng thân thiết, từng mua nhiều sản phẩm'},
#   {label: 1, name: 'Nhà đầu tư', intro: 'Khách mới'},

#   {label: 2, name: 'Email', intro: 'Khách hàng từ các chiến dịch email marketing'},
#   {label: 2, name: 'Facebook', intro: 'Khách hàng từ nguồn quảng cáo Facebook'},
#   {label: 2, name: 'Form CRM', intro: 'Khách nhập từ form CRM trên website'},
#   {label: 2, name: 'Giới thiệu', intro: 'Khách hàng được người khách giới thiệu'},
#   {label: 2, name: 'Google', intro: 'Khách hàng từ nguồn quảng cáo Google'},
#   {label: 2, name: 'Hotline', intro: 'Khách hàng từ đầu số hotline'},
#   {label: 2, name: 'Tờ rơi', intro: 'Khách hàng từ các chiến dịch phát tờ rơi'},
#   {label: 2, name: 'Youtube', intro: 'Khách hàng từ kênh quảng cáo Youtube'},

#   {label: 3, name: 'BOOK LỊCH HẸN VỚI HỌC VIÊN', intro: ''},
#   {label: 3, name: 'CHƯA XỬ LÝ', intro: 'Khách chưa được nhân viên xử lý  '},
#   {label: 3, name: 'EMAIL ACCOUNT, PASSWORD, STUDY PLAN', intro: 'Khách nhập từ form CRM trên website'},
#   {label: 3, name: 'FIRST CALLING', intro: 'Check đã đọc e-mail, bài học, group section.'},
#   {label: 3, name: 'MEETING WITH STUDENT', intro: 'Hẹn học sinh'},
#   {label: 3, name: 'PERFORMANCE REVIEW WEEKLY', intro: 'Theo dõi tiến độ học hàng tuần'},
#   {label: 3, name: 'Q&A WEEKLY', intro: 'Giải đáp thắc mắc hàng tuần'},
#   {label: 3, name: 'WELCOME EMAIL', intro: 'Thư chào mừng học sinh'},

#   {label: 4, name: 'Cập nhật tình trạng', intro: 'thay đổi trạng thái khách hàng', can_delete: false, can_modify: false},
#   {label: 4, name: 'Chuyển khách hàng', intro: 'Được chuyển cho nhân viên'},
#   {label: 4, name: 'Chưa gửi account, password, & study plans', intro: 'Chưa gửi account, password, & study plans cho khách hàng'},
#   {label: 4, name: 'Chưa nhận', intro: 'Chưa nhận mail'},
#   {label: 4, name: 'Done bluejeans', intro: 'Khách hàng đã cài và dùng thử thành công bluejeans'},
#   {label: 4, name: 'Gọi điện thoại', intro: 'gọi điện thoại cho khách hàng'},
#   {label: 4, name: 'Gửi email', intro: 'gửi email cho khách hàng'},
#   {label: 4, name: 'Không gọi được điện thoại', intro: 'Khách hàng không trả lời điện thoại follow up'},
#   {label: 4, name: 'Nhận cuộc gọi', intro: 'nhận được điện thoại từ khách hàng'},
#   {label: 4, name: 'Nhận email', intro: 'nhận được email từ khách hàng phản hồi'},
#   {label: 4, name: 'Nhận khách hàng', intro: 'Chia khách hàng cho'},
#   {label: 4, name: 'Nhắn tin', intro: 'nhắn tin tới khách hàng'},
#   {label: 4, name: 'Not yet Bluejeans', intro: 'Khách hàng đã cài và chưa dùng thử bluejeans đã cài'},
#   {label: 4, name: 'Office', intro: 'Hẹn trực tiếp'},
#   {label: 4, name: 'Skype', intro: 'Hẹn qua skype'},
#   {label: 4, name: 'Đã gọi điện thoại follow up hàng tuần', intro: 'đã gọi điện thoại follow up hàng tuần với khách hàng'},
#   {label: 4, name: 'Đã gửi account, pass & study plans', intro: 'Gửi account, pass & study plans cho khách hàng'},
#   {label: 4, name: 'Đã nhận email', intro: 'Đã nhận mail'},
# ]

# groups.each do |group|
#   Group.create(group)
# end

# Set roles
roles = ['admin', 'Scrum Master', 'Product Owner', 'Product', "Order"]

roles.each do |role|
  Role.create(name: role)
end

# Add permissions
actions = ['manage', 'read', 'create', 'update','approve', 'destroy']
subject_class = ActiveRecord::Base.connection.tables.reject{|x| x == 'schema_migrations'}.collect{|x| x.classify}.compact

subject_class.each_index do |sbj_idx|
  actions.each {|act| Permission.create(action: act, subject_class: subject_class[sbj_idx])}
end
