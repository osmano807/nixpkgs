{ lib, fetchFromGitLab, git, buildGoModule }:
let
  data = (builtins.fromJSON (builtins.readFile ../data.json));
in
buildGoModule rec {
  pname = "gitlab-workhorse";

  version = "14.3.3";

  src = fetchFromGitLab {
    owner = data.owner;
    repo = data.repo;
    rev = data.rev;
    sha256 = data.repo_hash;
  };

  sourceRoot = "source/workhorse";

  vendorSha256 = "sha256-piA14jYFV+FD20kR38rN1o329eeYAW/PmS0QI1GaU50=";
  buildInputs = [ git ];
  ldflags = [ "-X main.Version=${version}" ];
  doCheck = false;

  meta = with lib; {
    homepage = "http://www.gitlab.com/";
    platforms = platforms.linux;
    maintainers = with maintainers; [ fpletz globin talyz ];
    license = licenses.mit;
  };
}
