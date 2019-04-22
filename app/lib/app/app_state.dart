enum Actions{
  login,
  logout
}

/// App 状态
/// 
/// 状态中所有数据都应该是只读的，所以，全部以 get 的方式提供对外访问，不提供 set 方法
class AppState {
  /// J.W.T
  String _authorizationToken;

  // 获取当前的认证 Token
  get authorizationToken => _authorizationToken;

  // 获取当前是否处于已认证状态
  get authed => _authorizationToken.length > 0;

  AppState(this._authorizationToken);

  // 持久化时，从 JSON 中初始化新的状态
  static AppState fromJson(dynamic json) => json != null ? AppState(json['authorizationToken'] as String) : AppState('');

  // 更新状态之后，转成 JSON，然后持久化至持久化引擎中
  dynamic toJson() => {'authorizationToken': _authorizationToken};
}

/// Reducer
AppState reducer(AppState state, action) {
  switch(action) {
    case Actions.login:
      return AppState('J.W.T');
    case Actions.logout:
      return AppState('');
    default:
      return state;
  }
}
