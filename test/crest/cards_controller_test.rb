require 'test_helper'

class Crest::CardsControllerTest < ActionDispatch::IntegrationTest
  teardown { ENV.delete 'CREST_PHONE' }

  test 'the card is drawn at the path the host named' do
    assert_equal '/houseaccount.vcf', houseaccount_vcf_path
  end

  test 'the card arrives as a file a phone offers to save' do
    get houseaccount_vcf_path

    assert_response :success
    assert_equal 'text/vcard; charset=utf-8', response.headers['Content-Type']
    assert_includes response.headers['Content-Disposition'], 'inline; filename="houseaccount.vcf"'
    assert_includes response.body, "\r\nFN:HouseAccount\r\n"
    assert_includes response.body, "\r\nPHOTO;ENCODING=b;TYPE=PNG:"
  end

  test 'the card is cached until the number it carries changes' do
    get houseaccount_vcf_path
    tag = response.headers['ETag']

    assert_includes response.headers['Cache-Control'], 'public'

    get houseaccount_vcf_path, headers: { 'HTTP_IF_NONE_MATCH' => tag }

    assert_response :not_modified

    ENV['CREST_PHONE'] = '+18005550199'
    get houseaccount_vcf_path, headers: { 'HTTP_IF_NONE_MATCH' => tag }

    assert_response :success
    assert_includes response.body, "\r\nTEL;TYPE=CELL:+18005550199\r\n"
  end
end
