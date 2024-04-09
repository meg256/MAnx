combinations = []
    for x in itertools.combinations(SAMPLES["samples"], 2):
        combs.append('%s-%s.txt' %(x[0], x[1]))

rule dnadiff:
    output:
        combinations,
    input: 