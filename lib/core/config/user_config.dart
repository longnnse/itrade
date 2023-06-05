class UserConfig {
  ///[userId] là id của user đang sử dụng app.
  final int userId;

  ///[username] là tên đăng nhập của user đang sử dụng app.
  final String username;

  ///[donViId] là id của đơn vị mà user đang sử dụng app thuộc về.
  final int donViId;

  ///[phongBanId] là id của phong ban mà user đang sử dụng app thuộc về.
  final int phongBanId;

  ///[fullName] là tên đầy đủ của user đang sử dụng app.
  final String fullName;

  ///[roleName] là vai trò của user đang sử dụng app.
  final String roleName;

  ///[UserConfig] là class chứa thông tin của user đang sử dụng app.
  UserConfig({
    required this.roleName,
    required this.userId,
    required this.username,
    required this.donViId,
    required this.phongBanId,
    required this.fullName,
  });

  factory UserConfig.empty() {
    return UserConfig(
        donViId: -1,
        userId: -1,
        fullName: "",
        phongBanId: -1,
        roleName: "",
        username: "");
  }
}
