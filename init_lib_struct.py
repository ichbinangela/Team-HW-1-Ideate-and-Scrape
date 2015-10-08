import os
import sys
import getopt
import shutil

def main( argv ):

    try:
        opts, args = getopt.getopt( argv[1:], "n:d:", [] )
    except getopt.GetoptError as err: print( str(err) )

    opts_dict = {}
    map( lambda x: opts_dict.update( { x[0]: x[1] } ), opts )

    if "-n" not in opts_dict.keys():
        raise( "the name of the project has not been set yet!" )

    proj_name = opts_dict["-n"]
    dir_name = opts_dict.get( "-d", "./" + proj_name )
 
    cwdpath = os.getcwd()

    dirs = [
        "bin", "lib", "spec", "spec/testfiles"
    ]

    full_dirs = map( lambda x: "/".join( [cwdpath, dir_name, x] ) ,dirs )

    map( _dummy_clean_dir, full_dirs )
    map( os.makedirs, full_dirs )

    os.system( "bundle init" )
    os.system( "bundle install" )
    os.system( "mv Gemfile " + "/".join( [dir_name, "Gemfile"] ) )
    os.system( "mv Gemfile.lock " + "/".join( [dir_name, "Gemfile.lock"] ) )
    os.system( "touch " + "/".join( [dir_name, "lib", proj_name + "_main.rb"] ) )
    os.system( "touch " + "/".join( [dir_name, "spec", proj_name + "_spec.rb"] ) )

    exit(0)

def _dummy_clean_dir( path ):
    if os.path.exists( path ) and os.path.isdir( path ): shutil.rmtree( path )

if __name__ == "__main__": main( sys.argv )