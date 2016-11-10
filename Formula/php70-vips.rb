require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Vips < AbstractPhp70Extension
  init
  desc "Native part of php-vips"
  homepage "https://github.com/jcupitt/php-vips-ext"
  url "https://github.com/jcupitt/php-vips-ext/archive/v0.1.3.tar.gz"
  sha256 "dfd11b502e00ce7e406cf8f82fe48fe9612df1a818d3dc6cb4c8561092699ae8"
  head "https://github.com/jcupitt/php-vips-ext.git"

  depends_on "pkg-config" => :build

  depends_on "homebrew/science/vips"

  def install
    ENV.universal_binary if build.universal?

    args = []
    args << "--with-vips"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/vips.so"
    write_config_file if build.with? "config-file"
  end
end
