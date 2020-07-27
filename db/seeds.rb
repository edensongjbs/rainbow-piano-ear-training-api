# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



NOTES = {
    note_values: ["C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4"].cycle,
    solfege_values: ["Low Do", "Re", "Mi", "Fa", "Sol", "La", "Ti", "High Do"].cycle,
    pitch_names: ["Low C", "D", "E", "F", "G", "A", "B", "High C"].cycle
}

Note.destroy_all
Chord.destroy_all
User.destroy_all
ChordNote.destroy_all
ChordLevel.destroy_all
Game.destroy_all
Level.destroy_all
# LevelQuestion.destroy_all
NoteQuestion.destroy_all
Note.destroy_all
Question.destroy_all
# UserLevel.destroy_all
# User.destroy_all


8.times { Note.create(note_value: NOTES[:note_values].next, solfege_value: NOTES[:solfege_values].next, pitch_name: NOTES[:pitch_names].next) }

all_notes = Note.all.cycle

c = all_notes.next
d = all_notes.next
e = all_notes.next
f = all_notes.next
g = all_notes.next
a = all_notes.next
b = all_notes.next
c4 = all_notes.next

$possible_notes = [c, d, e, f, g, a, b, c4]

CHORDS = {
    roman_numerals: ["I", "ii", "iii", "IV", "V", "vi"].cycle,
    chord_names: ["C major", "D minor", "E minor", "F major","G major", "A minor"].cycle,
    notes:[[c, e, g], [d, f, a], [e, g, b], [f, a, c4], [g, b, d], [a, c4, e]].cycle,
}

6.times do
    chord = Chord.create(roman_numeral: CHORDS[:roman_numerals].next, chord_name: CHORDS[:chord_names].next)
    CHORDS[:notes].next.each_with_index do |e, i|
        chord.notes << e
        ChordNote.find_by(chord: chord, note: e).update_attributes(position: i)
    end
end

all_chords = Chord.all.cycle

i = all_chords.next
ii = all_chords.next
iii = all_chords.next
iv = all_chords.next
v = all_chords.next
vi = all_chords.next

# User.create(email: "James", password: "password", password_confirmation: "password")

# Games
## Note names



game1 = Game.create(name: "Note Names and Sequences", order_matters: true, intro_message: "Please play the note or notes that I say in order", list_note_names: true, either_c: false)

### Level 1: Low and High Do
g1l1 = [[c], [c4]]

### Level 2: Add Sol
g1l2 = [[g], [g], [c], [c4], [g]]
### Level 3: Add Mi
g1l3 = [[e], [e], [e], [g], [c], [c4]]
### Level 4: Same notes (2 note sequences)
g1l4 = []
[c,c4,e, g].each {|e1| [c,c4,e, g].each {|e2| g1l4 << [e1,e2]}}
### Level 5: Add Re (2 notes)
g1l5 = []
[c,c4,e,g].each do |e1| 
    g1l5 << [e1, d]
    g1l5 << [d, e1]
end  
g1l5 << [d,d]
### Level 6: Same notes (3 note sequences)
g1l6 = []
[c,c4,e, g, d].each {|e1| [c,c4,e, g, d].each {|e2| [c,c4,e,g,d].each {|e3| g1l6 << [e1,e2, e3]}}}
### Level 7: Add La (2 notes)
g1l7 = []
[c,c4,e,g, d].each do |e1| 
    g1l7 << [e1, a]
    g1l7 << [a, e1]
end
g1l7 << [a,a]
### Level 8: Add Fa (2 notes)
g1l8 = []
[c,c4,e,g, d, a].each do |e1| 
    g1l8 << [e1, f]
    g1l8 << [f, e1]
end
g1l8 << [f,f]
### Level 9: Add Ti (2 notes)
g1l9 = []
[c,c4,e,g, d, a, f].each do |e1| 
    g1l9 << [e1, b]
    g1l9 << [b, e1]
end
g1l9 << [b, b]
### Level 10: All Notes (3 note patterns)
g1l10 = []
[c,c4,e, g, d, a, f, b].each {|e1| [c,c4,e, g, d, a, f, b].each {|e2| [c,c4,e,g,d, a, f, b].each {|e3| g1l10 << [e1,e2, e3]}}}
### Level 11: All Notes (4 note patterns)
g1l11 = []
[c,c4,e, g, d, a, f, b].each {|e1| [c,c4,e, g, d, a, f, b].each {|e2| [c,c4,e,g,d, a, f, b].each {|e3| [c,c4,e,g,d, a, f, b].each {|e4| g1l11 << [e1,e2, e3, e4]}}}}

g1messages = [
    "Can you tell the difference between high Do (C) and low Do (C)?",
    "Now, we're going to add in Sol (G)!",
    "Now, we're going to add in Mi (E)!",
    "Now, I'm going to ask you to play two notes in a row!",
    "Now, we'll add in Re (D)!",
    "Let's try some 3 note sequences with Do, Re, Mi, and So!",
    "Now, we'll add in in La (A)!",
    "Now, we'll add in Fa (F)!",
    "We'll at in Ti (B) this time to finish our full scale!",
    "Now, I'm going to ask you to play 3 notes in a row from full scale!",
    "Finally, I'm going to you ask you to play 4 notes in a row from the full scale!"
].cycle

g1demo_notes = [
    "C4:C3", "G3", "E3","C3:D3:E3:G3", "D3", "", "A3", "F3", "B3","C3:D3:E3:F3:G3:A3:B3:C4","C3:D3:E3:F3:G3:A3:B3:C4"
].cycle

[g1l1, g1l2, g1l3, g1l4, g1l5, g1l6, g1l7, g1l8, g1l9, g1l10, g1l11].each_with_index do |level, i|
    lev = Level.create(level_num: i+1, level_message: g1messages.next, game: game1, demo_notes: g1demo_notes.next)
    # game1.levels << lev
    level.each do |question|
        questionString = question.map{|n| n.pitch_name}.join(', ') # is this going to create extra commas?
        quest1 = Question.create(level: lev, question_text: "#{question.length<=1 ? 'Play a ' : 'Play these notes in order: '}#{questionString}!", use_solfege: false)
        # debugger
        quest1.assign_notes(question)
        # lev.questions << quest1
        questionString = question.map{|n| n.solfege_value}.join(', ') # is this going to create extra commas?
        quest2 = Question.create(level: lev, question_text: "#{question.length<=1 ? 'Play a ' : 'Please these notes in order: '}#{questionString}!")
        quest2.assign_notes(question)
        # lev.questions << quest2
    end
end




## Chord Names
### Level 1: I Chord and V Chord
g2l1 = [i, v]
### Level 2: add IV
g2l2 = [iv, iv, i, v]
### Level 3: add ii
g2l3 = [ii, ii, ii, iv, i, v]
### Level 4: add vi
g2l4 = [vi, vi, vi, vi, ii, iv, i, v]
### Level 5: add iii
g2l5 = [iii, iii, iii, iii, vi, ii, iv, i, v]
### Level 6: all chords (equal likelihood)
g2l6 = [i, ii, iii, iv, v, vi]

g2messages = [
    "We'll start with the I chord and the V chord.  Both are major chords  Can you tell the difference?",
    "Now we're going to add the IV Chord.  Also a major chord",
    "Now we'll add our first minor chord: the ii chord.  Can you hear how it sounds different than the others?",
    "Now we'll add another minor chord.  The vi chord.",
    "Finally, let's add another minor chord:  the iii chord.",
    "Now I'm going to ask you about any of the chords we've learned about."
].cycle

g2demo_notes = [
    "C3:E3:G3:G3:B3:D3", "F3:A3:C4", "D3:F3:A3", "A3:C4:E3", "E3:G3:B3", ""
].cycle

game2 = Game.create(name: "Chord Names", intro_message: "Chords are a group of notes that go together.  I'm going to ask you to play some chords.", chords_allowed: true, either_c: true)



[g2l1, g2l2, g2l3, g2l4, g2l5, g2l6].each_with_index do |level, i|
    lev = Level.create(level_num: i+1, level_message: g2messages.next, demo_notes: g2demo_notes.next, game: game2)
    # game1.levels << lev
    level.each do |question|
        # questionString = question.map{|n| n.pitch_name}.join(', ') # is this going to create extra commas?
        quest1 = Question.create(level: lev, question_text: "Play a #{question.roman_numeral} chord!", use_solfege: false)
        # debugger
        quest1.assign_notes(question.chord_notes.sort_by{|e| e.position}.map{|e| e.note})
        # lev.questions << quest1
        # questionString = question.map{|n| n.solfege_value}.join(', ') # is this going to create extra commas?
        # quest2 = Question.create(level: lev, question_text: "#{question.length<=1 ? 'Play a ' : 'Please these notes in order: '}#{questionString}!")
        # quest2.assign_notes(question)
        # lev.questions << quest2
    end
end

# byebug

## Chord Listening
### Level 1: I and V (arpeggiated)
g3l1 = [i, v]
### Level 2: I and V (block)
g3l2 = [i, v]
### Level 3: add IV (arpeggiated)
g3l3 = [iv, iv, i, v]
### Level 4: block
g3l4 = [iv, iv, i, v]
### Level 5: add ii (arp)
g3l5 = [ii, ii, ii, iv, iv, i, v]
### Level 6: block
g3l6 = [ii, ii, ii, iv, iv, i, v]
### Level 7: add vi (arp)
g3l7 = [vi, vi, vi, vi, ii, ii, iv, i, v]
### Level 8: block
g3l8 = [vi, vi, vi, vi, ii, ii, iv, i, v]
### Level 9: all (arp)
g3l9 = [i, ii, iii, iii, iii, iii, iii, vi, iv, v, vi]
### Level 10: all (block)
g3l10 = [i, ii, iii, iv, v, vi]

g3messages = [
    "We'll start with the I chord and the V chord.  Both are major chords  Can you tell the difference?",
    "Now I'm going to play the notes of the chord together.",
    "Now we're going to add the IV Chord.  Also a major chord",
    "Now I'm going to play the notes of the chord together.",
    "Now we'll add our first minor chord: the ii chord.  Can you hear how it sounds different than the others?",
    "Now I'm going to play the notes of the chord together.",
    "Now we'll add another minor chord.  The vi chord.",
    "Now I'm going to play the notes of the chord together.",
    "Finally, let's add another minor chord:  the iii chord.",
    "Now, I'm going to ask you about all the chords we learned and I'll play them together.",
].cycle

g3demo_notes = [
    "C3:E3:G3:G3:B3:D3", "C3:E3:G3:G3:B3:D3", "F3:A3:C4", "F3:A3:C4", "D3:F3:A3", "D3:F3:A3", "A3:C4:E3", "A3:C4:E3", "E3:G3:B3", "E3:G3:B3"
].cycle

game3 = Game.create(name: "Chords by ear", intro_message: "Chords are a group of notes that go together.  I'm going to play some chords. Can you tell me which chords they are?", chords_allowed: true, play_first: true, either_c: true)


[g3l1, g3l2, g3l3, g3l4, g3l5, g3l6, g3l7, g3l8, g3l9, g3l10].each_with_index do |level, i|
    lev = Level.create(level_num: i+1, level_message: g3messages.next, demo_notes: g3demo_notes.next, game: game3, arpeggiated: i.even?)
    # game1.levels << lev
    level.each do |question|
        # questionString = question.map{|n| n.pitch_name}.join(', ') # is this going to create extra commas?
        quest1 = Question.create(level: lev, question_text: "Listen to the chord and play it back for me.", use_solfege: false)
        # debugger
        quest1.assign_notes(question.chord_notes.sort_by{|e| e.position}.map{|e| e.note})
        # lev.questions << quest1
        # questionString = question.map{|n| n.solfege_value}.join(', ') # is this going to create extra commas?
        # quest2 = Question.create(level: lev, question_text: "#{question.length<=1 ? 'Play a ' : 'Please these notes in order: '}#{questionString}!")
        # quest2.assign_notes(question)
        # lev.questions << quest2
    end
end

# byebug

## Melodic Patterns  //Generate algorithmically
### Level 1: Low and High Do (2 note)
g4l1a = [[c], [c4]]

g4l1 = []
[c, c4].each { |e1| [c,c4].each {|e2| g4l1 << [e1, e2]}}
### Level 2: Add Sol (2 note)

g4l2a = [[c], [c4], [g], [g]]
g4l2 = []
[c, c4, g].each { |e1| [c, c4, g].each {|e2| g4l2 << [e1, e2]}}
### Level 3: Add Mi (2 note)
g4l3a = [[c], [c4], [g], [e], [e], [e]]

g4l3 = []
[c, c4, g, e , e].each { |e1| [c, c4, g, e, e].each {|e2| g4l3 << [e1, e2]}}
### Level 4: Same notes (3 note sequences)
g4l4 = []
[c, c4, g, e].each { |e1| [c, c4, g, e ].each {|e2| [c, c4, g, e ].each {|e3| g4l4 << [e1, e2, e3]}}}
g4l5a = [[c], [c4], [g], [e], [d], [d], [d], [d]]
### Level 5: Add Re (3 notes)
g4l5b = []
[c, c4, g, e, d, d].each { |e2| [c, c4, g, e, d, d].each { |e3| g4l5b << [e2, e3] }}
g4l5 = []
g4l5 = []
[c, c4, g, e, d, d].each { |e1| [c, c4, g, e, d, d].each { |e2| [c, c4, g, e, d, d].each { |e3| g4l5 << [e1, e2, e3] }}}
### Level 6: Add La (3 notes)
g4l6a = [[c], [c4], [g], [e], [d], [a], [a], [a], [a]]
g4l6b = []
g4l6 =[]
[c, c4, g, e, d, a, a].each { |e2| [c, c4, g, e, d, a, a].each { |e3| g4l6b << [e2, e3] }}
[c, c4, g, e, d, a, a].each {|e1| [c, c4, g, e, d, a, a].each {|e2| [c, c4, g, e, d, a, a].each {|e3| g4l6 << [e1, e2, e3]}}}
### Level 7: Add Fa (3 notes)
g4l7a = [[c], [c4], [g], [e], [d], [a], [f], [f], [f], [f]]
g4l7b = []
g4l7 = []
[c, c4, g, e, d, a, f, f].each { |e2| [c, c4, g, e, d, a, f, f].each { |e3| g4l7b << [e2, e3] }}
[c, c4, g, e, d, a, f, f].each {|e1| [c, c4, g, e, d, a, f, f].each {|e2| [c, c4, g, e, d, a, f, f].each {|e3| g4l7 << [e1, e2, e3]}}}
### Level 8: Add Ti (3 notes)
g4l8a = [[c], [c4], [g], [e], [d], [a], [f], [b], [b], [b], [b], [b]]
g4l8b = []
[c, c4, g, e, d, a, f, b, b].each { |e2| [c, c4, g, e, d, a, f, b, b].each { |e3| g4l8b << [e2, e3] }}
g4l8 = []
[c, c4, g, e, d, a, f, b, b].each {|e1| [c, c4, g, e, d, a, f, b, b].each {|e2| [c, c4, g, e, d, a, f, b, b].each {|e3| g4l8 << [e1, e2, e3]}}}

### Level 9: All Notes (4 note patterns)
# [c, c4, g, e, d, a, f, b]
### Level 10: All Notes (5 note patterns)
# [c, c4, g, e, d, a, f, b]


# Melodic Rules:
# leaps are unlikely (larger the leap, less likely)
# moving in the same direction is more likely than reverse
# moving in reverse is more likely after a leap
# [1,1,1,1]
# [-1, -1, -1, -1]
# replace 1 with opposite direction
# replace 1 leap in opposite direction

possible_notes = [c, d, e, f, g, a, b, c4]

# possible_patterns = []
neg_patterns = []
pos_patterns = []


pos_patterns << [1, 1, 1, 1]
neg_patterns << [-1, -1, -1, -1]
new_pos = []
new_neg = []

4.times do |i|
    new_pattern = pos_patterns[0].clone
    # byebug
    new_pattern[i] = -new_pattern[i]
    new_pos << new_pattern
    puts new_pos
end
4.times do |i|
    new_pattern = neg_patterns[0].clone
    new_pattern[i] = -new_pattern[i]
    new_neg << new_pattern
end
puts "step 1"

pos_patterns = pos_patterns.concat(new_pos)
neg_patterns = neg_patterns.concat(new_neg)

# byebug
temp_pos = pos_patterns.clone
temp_neg = neg_patterns.clone
new_pos = []
new_neg = []

[2, 3, 4, 5].each do |e1|
    temp_pos.each do |e2|
        new_pattern = e2.clone
        4.times do |i|
            new_pattern_2 = new_pattern.clone 
            new_pattern_2[i] = e1.clone
            new_pos << new_pattern_2
            puts new_pos.length
        end
    end
    temp_neg.each do |e2|
        new_pattern = e2.clone
        4.times do |i| 
            new_pattern_2 = new_pattern.clone
            new_pattern_2[i] = e1.clone
            new_neg << new_pattern
            puts new_neg.length
        end
    end
end
puts "step 2"
# byebug

pos_patterns = temp_pos.concat(new_pos)
neg_patterns = temp_neg.concat(new_neg)

temp_pos = pos_patterns
temp_neg = neg_patterns
new_pos = []
new_neg = []

[2, 3].each do |e1|
    temp_pos.each do |e2|
        new_pattern = e2.clone
        new_pattern2 = e2.clone
        4.times do |i|
            new_pattern_2 = new_pattern.clone
            new_pattern_22 = new_pattern2.clone
            new_pattern_2[i] = e1.clone
            new_pattern_22[i] = -e1.clone
            new_pos << new_pattern_2
            new_pos << new_pattern_22
        end
    end
    temp_neg.each do |e2|
        new_pattern = e2.clone
        new_pattern2 = e2.clone
        4.times do |i|
            new_pattern_2 = new_pattern.clone
            new_pattern_22 = new_pattern2.clone
            new_pattern_2[i] = e1.clone
            new_pattern_22[i] = -e1.clone
            new_neg << new_pattern_2
            new_neg << new_pattern_22
        end
    end
end
puts "step 3"

# byebug

pos_patterns = temp_pos.concat(new_pos)
neg_patterns = temp_neg.concat(new_neg)

possible_patterns =  pos_patterns.concat(neg_patterns)
# byebug
g4l10 = []

def figure_it_out(starting_index, ar)
    new_ar = []
    new_ar[0] = starting_index
    x = 1
    while x<=ar.length
         new_ar[x] = new_ar[x-1] + ar[x-1]
         if (new_ar[x] < 0) || (new_ar[x] >= 8 )
            return nil
         end
         x += 1
        #  puts x
    end
    # byebug
    return p (new_ar.map{|e1| $possible_notes[e1]})
end

puts "step 4"

possible_patterns.each do |e1|    
    y = 0
    while y < 8
        g4l10 << figure_it_out(y, e1)
        y += 1
    end
    puts "finished loop #{e1}"
end

# puts "step 5"
# byebug
g4l10 = g4l10.reject{|h| h==nil}
g4l9 = g4l10.map{|h| h[0..3]}


# pos_patterns.each do |e1|
#     possible_notes.each_with_index do |e2, i|
#         current_pattern = [e2]
#         e1.reduce() do |memo, e3|
#             current_pattern << possible_notes[i+e3]

# def pattern_generate_with_starting_note(pitch_index, pattern_array)
#     array = [possible_patterns[pitch_index]]
#     pattern_array.map do |move|
        
#         array = possible_notes[current_note_index+move] 


# possible_notes.each_with_index do |e1, i1|
#     pos_patterns.map do |e2|
#         current_note_index = i1
#         e2.map do |e3|
#             m = current_note_index
#             current_note

g4messages = [
    "We'll start with High Do (C) and Low Do (C)",
    "Now I'll play two notes in a row using high Do and Low Do",
    "Now Let's add in Sol (G)!",
    "Now I'll play two notes in a row with Do and Sol",
    "Now we'll add Mi (E)!",
    "Now I'll play two notes in a row with Do, Mi, and Sol",
    "Now I'll play three notes in a row with Do, Mi, and Sol",
    "Now we'll add Re (D)",
    "Now I'll play two notes in a row with Do, Re, Mi, and Sol",
    "Now I'll play three notes in a row with Do, Re, Mi, and Sol",
    "Now we'll add La (A)",
    "Now I'll play two notes in a row with Do, Re, Mi, Sol, and La",
    "Now I'll play three notes in a row with Do, Re, Mi, Sol, and La",
    "Now we'll add Fa (F)",
    "Now I'll play two notes in a row with Do, Re, Mi, Fa, Sol, and La",
    "Now I'll play three notes in a row with Do, Re, Mi, Fa, Sol, and La",
    "Finally, we'll add Ti (B)",
    "Now I'll play two notes using the full scale",
    "Now I'll play three notes in a row using the full scale",
    "Now I'm going to play a 4 note melody using the whole scale.  Can you play it back?",
    "Finally, I'm going to play a 5 note melody using the whole scale.  Can you play it back?"
].cycle

g4demo_notes = [
    "C3:C4",
    "C3:C4",
    "G3",
    "C3:G3:C4",
    "E3",
    "C3:E3:G3",
    "C3:E3:G3",
    "D3",
    "C3:D3:E3:G3",
    "C3:D3:E3:G3",
    "A3",
    "C3:D3:E3:G3:A3",
    "C3:D3:E3:G3:A3",
    "F3",
    "C3:D3:E3:F3:G3:A3",
    "C3:D3:E3:F3:G3:A3",
    "B3",
    "C3:D3:E3:F3:G3:A3:B3",
    "C3:D3:E3:F3:G3:A3:B3",
    "C3:D3:E3:F3:G3:A3:B3:C4",
    "C3:D3:E3:F3:G3:A3:B3:C4"
].cycle

game4 = Game.create(name: "Notes by ear", intro_message: "Listen to notes that I play. Can you play them back for me?", order_matters: true, play_first: true, either_c: false)


[
    g4l1a,
    g4l1,
    g4l2a,
    g4l2,
    g4l3a,
    g4l3,
    g4l4,
    g4l5a,
    g4l5b,
    g4l5,
    g4l6a,
    g4l6b,
    g4l6,
    g4l7a,
    g4l7b,
    g4l7,
    g4l8a,
    g4l8b,
    g4l8,
    g4l9,
    g4l10].each_with_index do |level, i|
    lev = Level.create(level_num: i+1, level_message: g4messages.next, demo_notes: g4demo_notes.next, game: game4, arpeggiated: true)
    # game1.levels << lev
    level.each do |question|
        # questionString = question.map{|n| n.pitch_name}.join(', ') # is this going to create extra commas?
        quest1 = Question.create(level: lev, question_text: "Listen to the notes I play and play them back for me", use_solfege: false)
        # debugger
        # puts question
        quest1.assign_notes(question)
        # lev.questions << quest1
        # questionString = question.map{|n| n.solfege_value}.join(', ') # is this going to create extra commas?
        # quest2 = Question.create(level: lev, question_text: "#{question.length<=1 ? 'Play a ' : 'Please these notes in order: '}#{questionString}!")
        # quest2.assign_notes(question)
        # lev.questions << quest2
    end
end