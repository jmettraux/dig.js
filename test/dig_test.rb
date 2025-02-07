
#
# Testing dig.js
#
# Thu Feb  6 17:23:50 JST 2025
#

group 'dig.js' do

  setup do

    @browser = make_browser
  end

  test 'sanity' do

    assert @browser.evaluate('1 + 1'), 2
  end

  group 'with scalars' do

    test 'lookup failure' do

      assert(@browser.eval('D.ig(null, D.nada)'), nil)
      assert(@browser.eval('D.ig(undefined, D.nada)'), nil)

      assert(@browser.eval('D.ig(0, D.nada)'), nil)
      assert(@browser.eval('D.ig(true, D.nada)'), nil)
      assert(@browser.eval('D.ig(false, D.nada)'), nil)
      assert(@browser.eval('D.ig("diplomatically", D.nada)'), nil)
    end
  end

  group 'with arrays' do

    test 'success' do

      assert(@browser.eval('D.ig([ 0, 1 ], D[1])'), 1)
      assert(@browser.eval('D.ig([ 0, 1 ], D[0])'), 0)

      assert(
        @browser.eval(
          'D.ig(' +
            '{ customer: { name: "toto", links: [ "a", "b" ] } },' +
            'D.customer.links[1]' +
          ')'),
        'b')
    end
  end

  group 'with objects' do

    test 'success' do

      assert(
        @browser.eval(
          'D.ig(' +
            '{ customer: { name: "toto", links: [ "a", "b" ] } },' +
            'D.customer.name' +
          ')'),
        'toto')

      assert(
        @browser.eval(
          'D.ig(' +
            '{ customer: { name: "toto", links: [ "a", "b" ] } },' +
            'D.customer.links' +
          ')'),
        [ 'a', 'b' ])
    end
  end
end

