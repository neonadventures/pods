#
#  Be sure to run `pod spec lint osmscout.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "osmscout"
  s.version      = "0.1.0"
  s.summary      = "libosmscout offers high-level interfaces to offline rendering and routing using OpenStreetMap (OSM) data."

  s.description  = <<-DESC
                   libosmscout offers applications simple, high-level interfaces to offline rendering and routing functionalities based on OpenStreetMap (OSM) data.

                    It does so by preprocessing *.osm data files and generating platform independent compact binary data and index files for fast access.

                    The high level API offers simple datatypes and methods to fetch data based on these datatypes for use in map drawing, location of POIs and routing.

                    It also offers code for drawing maps (currently using cairo) base on these information.

                    The goals of libosmscout are:

                    * Support access to as much of the OSM metadata as possible.
                    * Implement as good routing functionality as possible.
                    * Strictly separate data handling and GUI, making it possible to use libosmscout with any toolkit you like.
                    * Work on low-end hardware like it is commonly used for handhelds, phones and similar.
                   DESC

  s.homepage     = "http://libosmscout.sourceforge.net/"
  s.author             = { "Nicholas Kostelnik" => "nkostelnik@gmail.com" }
  s.source       = { :git => "http://git.code.sf.net/p/libosmscout/code" }

  s.source_files  = 'libosmscout/src/**/*.cpp'
  s.public_header_files  = 'libosmscout/include/osmscout/CoreFeatures.h'
  s.header_mappings_dir = 'libosmscout/include/osmscout'
  s.compiler_flags = '-I/usr/local/include'

  s.post_install do |installer_representation|
    headers_path = File.join(installer_representation.sandbox.root, "Headers")
    FileUtils.cp_r("/tmp/osmscout", headers_path)
    FileUtils.rm_rf("/tmp/osmscout")
  end

  s.prepare_command = <<-CMD
    cd libosmscout
    ./autogen.sh && ./configure --disable-see2-support && make
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$(pwd)
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/src/.libs
    cd ..
    cp -rf libosmscout/include/osmscout /tmp
  CMD

end
