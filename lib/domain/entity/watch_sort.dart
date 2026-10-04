enum WatchSort {
  price('현재가순'),
  changeRate('등락률순'),
  name('가나다순');

  const WatchSort(this.word);
  final String word;
}
