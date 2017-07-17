require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Vips < AbstractPhp70Extension
  init
  desc "Native part of php-vips"
  homepage "https://pecl.php.net/package/vips"
  url "https://pecl.php.net/get/vips-1.0.7.tgz"
  sha256 "ddc3f396237af05ee4ef5f207b004c7b387b28736d9c1878dd24475a807c5337"
  head "https://github.com/jcupitt/php-vips-ext.git"

  depends_on "pkg-config" => :build
  depends_on "vips"

  def install
    Dir.chdir "vips-#{version}" unless build.head?

    args = []
    args << "--with-vips"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/vips.so"
    write_config_file if build.with? "config-file"
  end
end
