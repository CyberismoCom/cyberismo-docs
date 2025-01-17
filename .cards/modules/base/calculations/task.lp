base_task(Task) :-
    field(Task, "cardType", "base/cardTypes/task").

base_task(Task) :-
    field(Task, "cardType", "base/cardTypes/monthlyTask").

base_task(Task) :-
    field(Task, "cardType", "base/cardTypes/quarterlyTask").

base_task(Task) :-
    field(Task, "cardType", "base/cardTypes/annualTask").

transitionDenied(
    Task,
    "Review as not applicable",
    "To close this task as not applicable, you must first provide a justification. Fill in the justification field. Click 'Show more' to find this field."
    ) :-
        base_task(Task),
        not field(Task, "base/fieldTypes/justification", _).

policyCheckFailure(
    Task,
    "Task",
    "Review expired",
    @concatenate(
        "The review of this task has expired ",
        @daysSince(LastTransitioned) - ReviewPeriod,
        " day(s) ago. Choose a suitable workflow transition to update the date.")
    ) :-
        base_task(Task),
        field(Task, "lastTransitioned", LastTransitioned),
        field(Task, "base/fieldTypes/reviewPeriod", ReviewPeriod),
        field(Task, "workflowStateCategory", "closed"),
        @daysSince(LastTransitioned) > ReviewPeriod.

policyCheckFailure(
    Task,
    "Task",
    "Due date passed",
    @concatenate(
        "The due date of this task has passed ",
        @daysSince(DueDate),
        " day(s) ago. Complete and close the task.")
    ) :-
        base_task(Task),
        field(Task, "base/fieldTypes/dueDate", DueDate),
        not field(Task, "workflowStateCategory", "closed"),
        DueDate < @today().
