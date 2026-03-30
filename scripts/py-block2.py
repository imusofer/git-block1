with open("data/statuses.txt", encoding="utf-8") as f:
    count = 0
    for line in f:
        count+=1
        print(f"Status {count}: {line.strip()}")