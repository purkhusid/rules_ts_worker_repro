"Opinionated TypeScript target"

load("@aspect_rules_ts//ts:defs.bzl", _ts_project = "ts_project")
load("@npm//src/nodejs:eslint/package_json.bzl", eslint_bin = "bin")

def ts_project(name, srcs, eslintrc = "//src/nodejs:eslintrc", **kwargs):
    """A wrapper for the ts_project rule that sets some opinionated defaults.

    We pass the **kwargs to the ts_project rule, and then create a eslint_test target for the
    sources that are passed to the ts_project rule. The eslint target will have the same name as
    the ts_project target with the suffix "_eslint".

    Args:
        name: The name of the target.
        srcs: The sources for the target.
        eslintrc: The path to the eslint config file. We default to the one with our defaults from //src/nodejs.
        **kwargs: The rest of the arguments that will be passed to the ts_project.
    """
    _ts_project(
        name = name,
        srcs = srcs,
        **kwargs
    )

    srcs_to_lint = [src for src in srcs if src.endswith(".ts") or src.endswith(".tsx") or src.endswith(".js") or src.endswith(".jsx")]

    eslint_bin.eslint_test(
        name = "{}_eslint".format(name),
        args = [
            "--config $(location {eslintrc})".format(eslintrc = eslintrc),
        ] + ["{}/{}".format(
            native.package_name(),
            s,
        ) for s in srcs_to_lint],
        data = srcs_to_lint + [
            "//src/nodejs:node_modules/eslint-config-next",
            "//src/nodejs:node_modules/eslint-plugin-prettier",
            "//src/nodejs:node_modules/next",
            "//src/nodejs:node_modules/react",
            eslintrc,
        ],
        tags = ["lint"],
    )
