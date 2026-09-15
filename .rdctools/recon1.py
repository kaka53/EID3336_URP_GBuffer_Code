draw = describe_draw(eventId=3320)
actions = get_all_actions()
near = [a for a in actions if a['eventId'] >= 3290 and a['eventId'] <= 3345]
{'draw_3320': draw, 'nearby_actions': near}
