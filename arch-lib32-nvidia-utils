# $Id$
# Maintainer: Sven-Hendrik Haase <sh@lutzhaase.com>
# Maintainer: Felix Yan <felixonmars@archlinux.org>
# Contributor: Thomas Baechler <thomas@archlinux.org>
# Contributor: James Rayner <iphitus@gmail.com>
# Contributor: Aaron Plattner <aplattner@nvidia.com>
# Contributor: Darek Zielski <dz1125.bug.tracker@gmail.com>

_pkgbasename=nvidia-utils
pkgbase=lib32-$_pkgbasename
pkgname=('lib32-nvidia-utils' 'lib32-nvidia-libgl' 'lib32-opencl-nvidia')
pkgver=370.23
pkgrel=1
arch=('x86_64')
url="http://www.nvidia.com/"
license=('custom')
options=('!strip')

_arch='x86'
_pkg="NVIDIA-Linux-${_arch}-${pkgver}"
source=("http://us.download.nvidia.com/XFree86/Linux-${_arch}/${pkgver}/${_pkg}.run")
sha1sums=('05f4a1a52f71e274254669bfd196067f66a2c260')

prepare() {
    sh ${_pkg}.run --extract-only
}

process_manifest () {
    declare -A type_handlers=(
        # lib32-opencl-nvidia
        ["OPENCL_LIB"]="lib32-opencl-nvidia install_lib"
        ["OPENCL_LIB_SYMLINK"]="lib32-opencl-nvidia symlink_lib_with_path"

        # lib32-nvidia-libgl
        ["GLVND_LIB"]="lib32-nvidia-libgl install_lib"
        ["GLVND_SYMLINK"]="lib32-nvidia-libgl symlink_lib"
        ["GLX_CLIENT_LIB"]="lib32-nvidia-libgl install_glvnd"
        ["GLX_CLIENT_SYMLINK"]="lib32-nvidia-libgl symlink_glvnd"
        ["OPENGL_LIB"]="lib32-nvidia-libgl install_lib"
        ["OPENGL_SYMLINK"]="lib32-nvidia-libgl symlink_lib"
        ["TLS_LIB"]="lib32-nvidia-libgl install_tls"
        ["VDPAU_LIB"]="lib32-nvidia-libgl install_lib"
        ["VDPAU_SYMLINK"]="lib32-nvidia-libgl symlink_lib_with_path"

        # lib32-nvidia-utils
        ["CUDA_LIB"]="lib32-nvidia-utils install_lib"
        ["CUDA_SYMLINK"]="lib32-nvidia-utils symlink_lib_with_path"
        ["ENCODEAPI_LIB"]="lib32-nvidia-utils install_lib"
        ["ENCODEAPI_LIB_SYMLINK"]="lib32-nvidia-utils symlink_lib"
        ["NVCUVID_LIB"]="lib32-nvidia-utils install_lib"
        ["NVCUVID_LIB_SYMLINK"]="lib32-nvidia-utils symlink_lib"
        ["NVIFR_LIB"]="lib32-nvidia-utils install_lib"
        ["NVIFR_LIB_SYMLINK"]="lib32-nvidia-utils symlink_lib"
        ["UTILITY_LIB"]="lib32-nvidia-utils install_lib"
        ["UTILITY_LIB_SYMLINK"]="lib32-nvidia-utils symlink_lib"

        # Ignored entries
        ["INSTALLER_BINARY"]="ignored"          # provided by pacman
        ["KERNEL_MODULE_SRC"]="ignored"         # kernel modules are handled by the nvidia PKGBUILD
        ["DKMS_CONF"]="ignored"                 # dkms is not used
        ["LIBGL_LA"]="ignored"                  # .la files are not needed
        ["OPENCL_WRAPPER_LIB"]="ignored"        # provided by libcl
        ["OPENCL_WRAPPER_SYMLINK"]="ignored"    # provided by libcl
        ["OPENGL_HEADER"]="ignored"             # provided by mesa
        ["UTILITY_BIN_SYMLINK"]="ignored"       # provided by pacman
        ["XMODULE_NEWSYM"]="ignored"            # not needed for modern X servers
        ["XMODULE_SYMLINK"]="ignored"           # not needed for modern X servers

        # Ignored entries for lib32-* packages
        ["CUDA_ICD"]="ignored"                  # lib32-opencl-nvidia
        ["APPLICATION_PROFILE"]="ignored"       # lib32-nvidia-libgl
        ["NVIDIA_MODPROBE_MANPAGE"]="ignored"
        ["NVIDIA_MODPROBE"]="ignored"
        ["GLX_MODULE_SHARED_LIB"]="ignored"
        ["GLX_MODULE_SYMLINK"]="ignored"
        ["VULKAN_ICD_JSON"]="ignored"
        ["XMODULE_SHARED_LIB"]="ignored"
        ["XORG_OUTPUTCLASS_CONFIG"]="ignored"
        ["UTILITY_BINARY"]="ignored"            # lib32-nvidia-utils
        ["DOT_DESKTOP"]="ignored"
        ["MANPAGE"]="ignored"
        ["DOCUMENTATION"]="ignored"
    )

    tail -n +9 .manifest | {
        while read name perm type extra1 extra2 extra3; do
            if [ ${type_handlers[${type}]+isset} ]; then
                local data=( ${type_handlers[${type}]} )
                local pkg=${data[0]}
                local handler=${data[1]}

                # Check if this file type is handled by the current package.
                # Otherwise, ignore it.
                if [ ${pkg} = ${pkgname} ]; then
                    eval ${handler} $name $perm $type $extra1 $extra2 $extra3
                fi
            else
                echo "Unrecognized manifest type ${type}"
                exit 1
            fi
        done
    }

    mkdir -p "${pkgdir}/usr/share/licenses"
    ln -s nvidia "${pkgdir}/usr/share/licenses/${pkgname}"
}

install_lib()           { install -D -m$2 "$1" "${pkgdir}/usr/lib32/$5$1"; }

install_glvnd()         {
    case "$5" in
        NON_GLVND)
            # legacy non-GLVND GLX libraries
            ;;
        GLVND)
            install -D -m$2 "$1" "${pkgdir}/usr/lib32/$1";
            ;;
    esac
}

install_tls()           {
    # Only "new" TLS is needed on modern systems.
    case $5 in
        CLASSIC)
            return
            ;;
        NEW)
            install -D -m$2 "$1" "${pkgdir}/usr/lib32/$1"
            ;;
        *)
            echo "Unrecognized TLS library type $5"
            exit 1
            ;;
    esac
}

symlink_lib()           { ln -s "$5" "${pkgdir}/usr/lib32/$1"; }
symlink_lib_with_path() { ln -s "$6" "${pkgdir}/usr/lib32/$5$1"; }

symlink_glvnd()         {
    case "$6" in
        NON_GLVND)
            # legacy non-GLVND GLX symlinks
            ;;
        GLVND)
            ln -s "$5" "${pkgdir}/usr/lib32/$1";
            ;;
    esac
}

package_lib32-opencl-nvidia() {
    pkgdesc="OpenCL implemention for NVIDIA (32-bit)"
    depends=('lib32-libcl' 'lib32-zlib' 'lib32-gcc-libs')
    optdepends=('opencl-headers: headers necessary for OpenCL development')
    cd "${_pkg}"

    process_manifest
}

package_lib32-nvidia-libgl() {
    pkgdesc="NVIDIA drivers libraries (32-bit)"
    depends=('nvidia-libgl')
    provides=('lib32-libgl' 'lib32-libglvnd' 'lib32-libegl' 'lib32-libgles')
    conflicts=('lib32-libgl' 'lib32-libglvnd' 'lib32-libegl' 'lib32-libgles')
    optdepends=('lib32-libvdpau: VDPAU wrapper library')
    cd "${_pkg}"

    process_manifest
}

package_lib32-nvidia-utils() {
    pkgdesc="NVIDIA drivers utilities (32-bit)"
    depends=('lib32-zlib' 'lib32-gcc-libs' 'nvidia-utils')
    optdepends=('lib32-opencl-nvidia')
    cd "${_pkg}"

    process_manifest
}
