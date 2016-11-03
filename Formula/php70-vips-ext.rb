require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70VipsExt < AbstractPhp70Extension
  init
  desc "Native part of php-vips"
  homepage "https://github.com/jcupitt/php-vips-ext"
  url "https://github.com/jcupitt/php-vips-ext/archive/v0.1.2.tar.gz"
  sha256 "72d7e821d2899729de0f9ff616350721d12371e08016f069f5b5836837f5e859"
  head "https://github.com/jcupitt/php-vips-ext.git"

  depends_on "pkg-config" => :build

  depends_on "vips"

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
