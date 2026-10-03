enum ErrorCode {
  network(1001, '인터넷 연결을 확인해 주세요'),
  timeout(1002, '요청 시간이 초과되었습니다'),
  server(1003, '서버 오류'),
  parse(1004, '데이터 해석 오류'),
  unknown(9999, '알 수 없는 오류');

  const ErrorCode(this.code, this.message);
  final int code;
  final String message;
}
