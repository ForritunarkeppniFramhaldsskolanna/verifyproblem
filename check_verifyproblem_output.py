#!/usr/bin/python3
import re, sys

class SubmissionInfo:
    def __init__(self, submission_type, filename, language, status, verdict, points, extra):
        self.submission_type = submission_type
        self.filename = filename
        self.language = language
        self.status = status
        self.verdict = verdict
        self.points = int(points)
        self.extra = extra

    def __str__(self):
        return str(self.__dict__)


problemname = sys.argv[1]
num_groups = int(sys.argv[2]) if len(sys.argv) > 2 else 1

exit_code = 0
PATTERN = '^\\s*(P?AC) submission (.*) \\((.*)\\) (.*): (.*) \\((.*)\\) (.*)\n$'
pointset = set()
p = re.compile(PATTERN)
for line in sys.stdin:
    m = p.match(line)
    if m:
        info = SubmissionInfo(*m.groups())
        pointset.add(info.points)
        has_score_pattern = re.compile(".*_\d*\\..*".format(info.points))
        filename_pattern = re.compile(".*_{}\\..*".format(info.points))
        if has_score_pattern.match(info.filename) and not filename_pattern.match(info.filename):
            print("::warning file={},title=Solution score mismatch::Solution {} scored {} instead of the expected amount".format(info.filename, info.filename, info.points))
    elif line.startswith('ERROR'):
        print("::error title=Error while verifying problem {}::{}".format(problemname, line))
    elif line.startswith('WARNING'):
        print("::warning title=Warning while verifying problem {}::{}".format(problemname, line))


if 0 not in pointset:
    print("::error title=Missing WA solution::No solution scores 0 points")
    exit_code = 1

if len(pointset.difference(set([0]))) < num_groups:
    print("::error title=Missing model solution::At least one test group is missing a model solution")
    exit_code = 1

sys.exit(exit_code)
