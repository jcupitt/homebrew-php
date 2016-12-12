require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Vips < AbstractPhp70Extension
  init
  desc "Native part of php-vips"
  homepage "https://github.com/jcupitt/php-vips-ext"
  url "https://github.com/jcupitt/php-vips-ext/archive/v1.0.2.tar.gz"
  sha256 "52d005ecc18930c97e1927c6a8b5d9390614946520b895fea42a5b790e34c4df"
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
