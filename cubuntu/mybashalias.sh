
###############################
###############################
## my bash alias definitions ##
###############################
###############################

###############################
#### multi-purpose aliases ####
###############################

# source code browsing
alias detag='rm -rf cscope.out; rm -rf tags'
alias retag='cscope -Rb && ctags -R'

###############################
#### path specific aliases ####
###############################

### Miscellaneous regulars ####
alias src='cd /home/vchn075/ChetaN/Refs'
alias scrap='cd /home/vchn075/ChetaN/Junk/scrap'
alias wrk='cd /home/vchn075/ChetaN/snips'
alias gitst='git status'

### Current Projects ###

# AMDU_CROF #
alias amdu='cd /home/vchn075/ChetaN/Projects/amdu_crof'
alias dpdk_amdu='cd /home/vchn075/ChetaN/Projects/amdu_crof/gerrito/amdu_crof/dpdk/16.07'

# VIVU_WPMD #
alias vivu='cd /home/vchn075/ChetaN/Projects/vivu_wpmd'
alias wpmd='cd /home/vchn075/ChetaN/Projects/vivu_wpmd/gerrit/vivu_wpmd/dpdk-17.05/'

# XILU_iOVS #
alias iovs='cd /home/vchn075/ChetaN/Projects/xilu_iovs'
alias dpdk_iovs='cd /home/vchn075/ChetaN/Projects/xilu_iovs/svn/xilu_iovs/trunk/dpdk-16.04'

# FSLU_NVME #
alias sfslu='cd /home/vchn075/ChetaN/Projects/fslu_nvme'

