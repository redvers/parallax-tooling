self: super:
{
  spinsim       = super.callPackage ./pkgs/spinsim { };
  propeller-gcc = super.callPackage ./pkgs/propeller-gcc { };
  spin2cpp      = super.callPackage ./pkgs/spin2cpp { };
  p2gcc         = super.callPackage ./pkgs/p2gcc { };
}
