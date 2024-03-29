# Using pre-CxxWrap SDPABuilder.jl, from
# https://github.com/JuliaOpt/SDPABuilder/releases/download/v7.3.8-static
function install_bb_sdpa(prefix, verbose)
    products = [
        ExecutableProduct(prefix, "sdpa", :sdpa),
        LibraryProduct(prefix, ["libsdpa"], :libsdpa),
    ]
    
    # Download binaries from hosted location
    bin_prefix = "https://github.com/JuliaOpt/SDPABuilder/releases/download/v7.3.8-static"
    
    # Listing of files generated by BinaryBuilder:
    download_info = Dict(
        Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/SDPABuilder.v7.3.8.aarch64-linux-gnu-gcc4.tar.gz", "bf2543fde1ef945db26f88cdf0fd51dbe9ffc541bd9c295171fc3ad7e39990e4"),
        Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/SDPABuilder.v7.3.8.aarch64-linux-gnu-gcc7.tar.gz", "1df7b8aef9f6e443594fe3ef30429f8eaa43115575e0c1bb4d8ab6bad1f5545d"),
        Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/SDPABuilder.v7.3.8.aarch64-linux-gnu-gcc8.tar.gz", "3f5e5fb7af59a069d500ce39497824a6513d30e5cc6825f1034b1d29176cd3de"),
        Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/SDPABuilder.v7.3.8.arm-linux-gnueabihf-gcc4.tar.gz", "998f4a7c36bc4a45691106e3bd7e9cd64f5bc083e20012087650df3e0d3862da"),
        Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/SDPABuilder.v7.3.8.arm-linux-gnueabihf-gcc7.tar.gz", "1cf689751003fbacebfe1d742148425e0639521dfad66e124462a75ba839fe2a"),
        Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/SDPABuilder.v7.3.8.arm-linux-gnueabihf-gcc8.tar.gz", "647e6d21f6e3d9098c7040ab3e379429f1cfa7ad72a25afbf9402468b6eb596e"),
        Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/SDPABuilder.v7.3.8.i686-linux-gnu-gcc4.tar.gz", "3e8987c17c51a7477c535a2c1447ba10d4a3114db4212772f2dca4c063216e77"),
        Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/SDPABuilder.v7.3.8.i686-linux-gnu-gcc7.tar.gz", "cb77b05df2e8ba3a77501ba4d4356b38fd31f371cf7141d4069544a1ba584e06"),
        Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/SDPABuilder.v7.3.8.i686-linux-gnu-gcc8.tar.gz", "a4cd08dfc694e58d8f14b8322c781ff5bcb31db8b40459a68e6178dbe7e38c19"),
        Windows(:i686, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/SDPABuilder.v7.3.8.i686-w64-mingw32-gcc4.tar.gz", "8b725e5026e28525d00f045f43245391a7e3af2413e65a3a40ec5e136ed7fd24"),
        Windows(:i686, compiler_abi=CompilerABI(:gcc6)) => ("$bin_prefix/SDPABuilder.v7.3.8.i686-w64-mingw32-gcc6.tar.gz", "1edb3c4cf8ee8b7ece05c33407fc94b4ad1a54dc900c2d901c77b78292d6de73"),
        Windows(:i686, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/SDPABuilder.v7.3.8.i686-w64-mingw32-gcc7.tar.gz", "05cf8abda808ecf9cea192c911675424eba01836b0d0f5e5acf62e6391989376"),
        Windows(:i686, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/SDPABuilder.v7.3.8.i686-w64-mingw32-gcc8.tar.gz", "fd522c0ea48c6c3f900858e17c8e22c9f43d69f941145ec71e5dd2cd78e3502e"),
        MacOS(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-apple-darwin14-gcc4.tar.gz", "78cf51f013f8256d30e65879efa30ff4aed20b8817efe2370a44ba2460000294"),
        MacOS(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-apple-darwin14-gcc7.tar.gz", "07d2e757ae3224d0295259269be98726411387b9b8bfe4d318bdf78ef8f5526b"),
        MacOS(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-apple-darwin14-gcc8.tar.gz", "a31361e59ad00744bf41b11d184ce3e5958976bb73d10ab6c38a7a56a3994130"),
        Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-linux-gnu-gcc4.tar.gz", "aa3a1996d3d485e84aab82a63a32202c3b7e44156747ce476f35f57b8ca4ece9"),
        Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-linux-gnu-gcc7.tar.gz", "ef898e2b04703290737ae000b5ae220c5d3ab7e6e6d22820e7bcad8220f839ab"),
        Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-linux-gnu-gcc8.tar.gz", "5d33d181a5166bbe1a96f1d4eafdd68b746533475e997e8a3bd12b033f97f87a"),
        Windows(:x86_64, compiler_abi=CompilerABI(:gcc4)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-w64-mingw32-gcc4.tar.gz", "ee8c532abe30c77583036778f899d3c5a1a17b9c0d8735f9c57446e3c8f991b8"),
        Windows(:x86_64, compiler_abi=CompilerABI(:gcc6)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-w64-mingw32-gcc6.tar.gz", "d427a9b8b5fe76682f04fdaa4089dc5ff8dcacc37a502045a67a0c5f1b398523"),
        Windows(:x86_64, compiler_abi=CompilerABI(:gcc7)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-w64-mingw32-gcc7.tar.gz", "945bd80f6c14f0967a9dab5d8fed39e747ec7da1959451cc59f696888a09520d"),
        Windows(:x86_64, compiler_abi=CompilerABI(:gcc8)) => ("$bin_prefix/SDPABuilder.v7.3.8.x86_64-w64-mingw32-gcc8.tar.gz", "245c4976fef193eca4b3fcad3d738f88d2994c81874d3bbe7c22b88ec79ce767"),
    )
    
    # Install unsatisfied or updated dependencies:
    unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
    dl_info = choose_download(download_info, platform_key_abi())
    if dl_info === nothing && unsatisfied
        # If we don't have a compatible .tar.gz to download, complain.
        # Alternatively, you could attempt to install from a separate provider,
        # build from source or something even more ambitious here.
        error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")
    end
    
    # If we have a download, and we are unsatisfied (or the version we're
    # trying to install is not itself installed) then load it up!
    if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
        # Download and install binaries
        install(dl_info...; prefix=prefix, force=true, verbose=verbose)
    end
    
    return products
end
