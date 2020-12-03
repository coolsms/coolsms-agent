INSERT INTO msg(payload) VALUES(json_object(
  'to', '01000000001',
  'from', '020000001',
  'text', '테스트 메시지',
  'type', 'SMS'
));

INSERT INTO msg(payload) VALUES(json_object(
  'to', '01000000001',
  'from', '020000001',
  'text', '테스트 메시지',
  'country', '82',
  'subject', '대체 발송',
  'text', '친구톡 테스트입니다.',
  'autoTypeDetect', true,
  'kakaoOptions', json_object(
    'pfId', 'KA01PF1903260033550428GGGGGGGGGG',
    'buttons', json_array(json_object(
      'buttonName', '홈페이지',
      'buttonType', 'WL',
      'linkPc', 'https://www.example.com',
      'linkMo', 'https://m.example.com'
    ), json_object(
      'buttonName', '앱 링크',
      'buttonType', 'AL',
      'linkIos', 'iosscheme://',
      'linkAnd', 'androidscheme://'
    ))
  )
));
