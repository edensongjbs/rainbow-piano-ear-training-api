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
game1 = Game.create(name: "Note Names and Sequences", order_matters: true, intro_message: "Please play the note or notes that I say in order", list_note_names: true)

### Level 1: Low and High Do
g1l1 = [[c], [c4]]

### Level 2: Add Sol
g1l2 = [[g]]
### Level 3: Add Mi
g1l3 = [[e]]
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
[c,c4,e, g, d].each {|e1| [c,c4,e, g, d].each {|e2| [c,c4,e,g,d].each {|e3| g1l4 << [e1,e2, e3]}}}
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
[c,c4,e, g, d, a, f, b].each {|e1| [c,c4,e, g, d, a, f, b].each {|e2| [c,c4,e,g,d, a, f, b].each {|e3| g1l4 << [e1,e2, e3]}}}
### Level 11: All Notes (4 note patterns)
g1l11 = []
[c,c4,e, g, d, a, f, b].each {|e1| [c,c4,e, g, d, a, f, b].each {|e2| [c,c4,e,g,d, a, f, b].each {|e3| [c,c4,e,g,d, a, f, b].each {|e4| g1l4 << [e1,e2, e3, e4]}}}}

g1messages = [
    "Can you tell the difference between high C or Do and low C or Do?",
    "Now, we're going to add in Sol (G)",
    "Now, we're going to add in Mi (E)",
    "Now, I'm going to ask you to play two notes in a row",
    "Now, we'll add in Re (D)",
    "Let's try some 3 note sequences",
    "Now, we're addin in La (A)",
    "We'll at in Ti (B) this time to finish our full scale",
    "Now, I'm going to ask you to play 3 notes in a row",
    "Finally, I'm going to you ask you to play 4 notes in a row",
].cycle

[g1l1, g1l2, g1l3, g1l4, g1l5, g1l6, g1l7, g1l8, g1l9, g1l10, g1l11].each_with_index do |level, i|
    lev = Level.create(level_num: i+1, level_message: g1messages.next)
    game1.levels << lev
    level.each do |question|
        questionString = question.map{|n| n.pitch_name}.join(', ') # is this going to create extra commas?
        quest1 = Question.create(question_text: "#{question.length<=1 ? 'Play a ' : 'Play these notes in order: '}#{questionString}!", use_solfege: false)
        debugger
        quest1.assign_notes(question)
        lev.questions << quest1
        questionString = question.map{|n| n.solfege_value}.join(', ') # is this going to create extra commas?
        quest2 = Question.create(question_tex: "#{question.length>1 ? 'Play a ' : 'Please these notes in order: '}#{questionString}!")
        quest2.assign_notes(question)
        lev.questions << quest2
    end
end


## Chord Names
### Level 1: I Chord and V Chord
g2l1 = [i, v]
### Level 2: add IV
g2l2 = [iv]
### Level 3: add ii
g2l3 = [ii]
### Level 4: add vi
g2l4 = [vi]
### Level 5: add iii
g2l5 = [iii]

## Chord Listening
### Level 1: I and V (arpeggiated)
### Level 2: I and V (block)
### Level 3: add IV (arpeggiated)
### Level 4: block
### Level 5: add ii (arp)
### Level 6: block
### Level 7: add vi (arp)
### Level 8: block
### Level 9: all (arp)
### Level 10: all (block)

## Melodic Patterns  //Generate algorithmically
### Level 1: Low and High Do (2 note)
### Level 2: Add Sol (2 note)
### Level 3: Add Mi (2 note)
### Level 4: Same notes (3 note sequences)
### Level 5: Add Re (3 notes)
### Level 6: Add La (3 notes)
### Level 7: Add Fa (3 notes)
### Level 8: Add Ti (3 notes)
### Level 9: All Notes (4 note patterns)
### Level 10: All Notes (5 note patterns)


