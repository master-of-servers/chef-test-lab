################################################################################
# Style file for markdownlint.
#
# https://github.com/markdownlint/markdownlint/blob/master/docs/configuration.md
#
# This file is referenced by the project `.mdlrc`.
################################################################################

#===============================================================================
# Start with all built-in rules.
# https://github.com/markdownlint/markdownlint/blob/master/docs/RULES.md
all

#===============================================================================
# Override default parameters for some built-in rules.
# https://github.com/markdownlint/markdownlint/blob/master/docs/creating_styles.md#parameters

# Ignore line length in code blocks.
rule 'MD013', code_blocks: false

#===============================================================================
# Exclude the rules I disagree with.

# IMHO it's easier to read lists like:
# * outmost indent
#   - one indent
#   - second indent
# * Another major bullet
exclude_rule 'MD004' # Unordered list style

# We like ordered lists.
exclude_rule 'MD029'

# Spaces after list markers are fine.
exclude_rule 'MD030'

# I find it necessary to use '<br/>' to force line breaks.
exclude_rule 'MD033'

# Bare URLs are fine.
exclude_rule 'MD034'
