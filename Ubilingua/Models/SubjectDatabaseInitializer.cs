using System.Collections.Generic;
using System.Data.Entity;

namespace Ubilingua.Models
{
    public class SubjectDatabaseInitializer : DropCreateDatabaseIfModelChanges<SubjectContext>
    {
        protected override void Seed(SubjectContext context)
        {
            GetSubjects().ForEach(s => context.Subjects.Add(s));
            GetBlocks().ForEach(b => context.Blocks.Add(b));
            GetResources().ForEach(r => context.Resources.Add(r));
            GetTeachers().ForEach(t => context.Teachers.Add(t));
            context.TeacherPasswords.Add(new TeacherPassword { Password = "profesor"});
        }

        private static List<Subject> GetSubjects()
        {
            var subjects = new List<Subject>
            {
                new Subject
                {
                    SubjectID=1,
                    SubjectName="Ingles",
                    ImagePath="uk.jpg",
                    IsPrivate=false
                },
                new Subject
                {
                    SubjectID=2,
                    SubjectName="Frances",
                    ImagePath="france.jpg",
                    IsPrivate=false
                },
                new Subject
                {
                    SubjectID=3,
                    SubjectName="Aleman",
                    ImagePath="germany.jpg",
                    IsPrivate=false
                },
            };
            return subjects;
        }

        private static List<Block> GetBlocks()
        {
            var blocks = new List<Block>
            {
                new Block
                {
                    BlockID=1,
                    BlockName="Tema 1",
                    SubjectID=1
                },
                new Block
                {
                    BlockID=2,
                    BlockName="Tema 2",
                    SubjectID=1
                },
                new Block
                {
                    BlockID=3,
                    BlockName="Tema 1",
                    SubjectID=2
                },
                new Block
                {
                    BlockID=4,
                    BlockName="Tema 3",
                    SubjectID=1
                },
            };
            return blocks;
        }

        private static List<Resource> GetResources()
        {
            var resources = new List<Resource>
            {
                new Resource
                {
                    ResourceID=1,
                    ResourceName="Recurso1",
                    ResourcePath="~",
                    BlockID=2,
                    IsVisible=true,
                    ResourceType="text"
                },
                new Resource
                {
                    ResourceID=2,
                    ResourceName="Recurso2",
                    ResourcePath="~",
                    BlockID=1,
                    IsVisible=true,
                    ResourceType="text"
                },
                new Resource
                {
                    ResourceID=3,
                    ResourceName="Recurso3",
                    ResourcePath="~",
                    BlockID=1,
                    IsVisible=true,
                    ResourceType="text"
                },
            };
            return resources;
        }

        private static List<Teacher> GetTeachers()
        {
            var teachers = new List<Teacher>
            {
                new Teacher
                {
                    TeacherID=0,
                    TeacherName="Agustía Darias Marrero",
                    Position="RESPONSABLE DE FRANCÉS / RESPONSABLE POUR LE FRANÇAIS",
                    SpanishRole="Además de ser el coordinador de este grupo, su papel fundamental en su seno es la elaboración de material didáctico para el aprendizaje del francés como lengua extranjera y de la interpretación.",
                    OtherRole="Dans ce Groupe d’Innovation Éducative (GIE) dont il assure la coordination, sa principale mission est d’élaborer des ressources didactiques pour l’enseignement et l’apprentissage du français langue étrangère et de l’interprétation.",
                    SpanishCV="Agustín Darias Marrero es Master en Interpretación de Conferencias por la Universidad de La Laguna y Doctor en Traducción e Interpretación por la ULPGC en la que ejerce como profesor de interpretación simultánea y consecutiva en el par de lenguas francés – español. En la actualidad es miembro del grupo de investigación de la ULPGC, Cultura y textos en la traducción oral y escrita, y forma parte del proyecto de investigación del  Ministerio de Ciencia e Innovación, Caracterización objetiva de la dificultad general de los originales. Estos focos de interés han sido objeto de sus publicaciones y comunicaciones en congresos nacionales e internacionales. Su línea de investigación principal se ha enriquecido más recientemente con la perspectiva de la interculturalidad y la incorporación de las TIC aplicadas a los procesos de enseñanza y aprendizaje.",
                    OtherCV="Diplômé d’un Master en interprétation de conférences à l’Université de La Laguna et d’un Doctorat en traduction et en interprétation à l’Université de Las Palmas de Gran Canaria, Agustín Darias Marrero est maître de conférences dans cette université où il donne des cours d’interprétation consécutive et simultanée français – espagnol. À l’heure actuelle, il participe au groupe de recherche Culture et textes en traduction orale et écrite, et il est également membre du projet de recherche du Ministère espagnol des Sciences et de l’innovation, Caractérisation objective de la difficulté générale des textes originaux. Dans le cadre de ces travaux il a réalisé plusieurs publications et a participé à des congrès nationaux et internationaux. Il a mené aussi des recherches sur la diversité culturelle et l’utilisation des TICE.",
                    Image="teacher0.jpg",
                },
                new Teacher
                {
                    TeacherID=1,
                    TeacherName="Ana Ruth Vidal Luengo",
                    Position="RESPONSABLE DE ÁRABE",
                    SpanishRole="Su función dentro del grupo es la creación de materiales didácticos en lengua árabe y la investigación sobre su aplicación a contextos nómadas, con especial atención a los espacios interculturales y su función en el proceso de aprendizaje.",
                    OtherRole="إن وظيفتها في المجموعة هي إنشاء ملفات تدريب باللغة العربية  والبحث العلمي في تطبيق هذه الموارد في سياق التنقل مع إبداء اهتمام خاص للمجالات ما بين الثقافات ووظيفتها في عملية التعلم.",
                    SpanishCV="Ana Ruth Vidal Luengo es profesora de lengua y literatura árabe de la Universidad de Las Palmas de Gran Canaria. Es Doctora en Filología Semítica por la Universidad de Granada y miembro de los grupos de investigación Paces imperfectas del Instituto de la Paz y los Conflictos de la Universidad de Granada, y Análisis lingüístico y edición de textos (en la línea de investigación La competencia comunicativa, los textos y el proceso de enseñanza/aprendizaje en la era de Internet) de la ULPGC. Ha estudiado árabe clásico en Túnez y Jordania y ha realizado diversas estancias en Egipto, Francia y Marruecos. Su línea de investigación principal sobre las cosmovisiones de paz y la regulación de conflictos en ámbito árabe-islámico le ha llevado a publicar diversos trabajos sobre las mediaciones entre paz y violencia y la interculturalidad, sobre todo en el ámbito literario, y ha derivado en otras líneas de trabajo, como la didáctica de ELE/L2 (Español como Lengua Extranjera o Segunda Lengua) a aprendientes arabófonos y la cultura de paz a través de la enseñanza de lenguas. Ha participado en el proyecto Web@idiomas y en la actualidad desarrolla una investigación en el marco de este Grupo de Innovación Educativa sobre la enseñanza-aprendizaje ubicuo de la lengua árabe a través de las TIC.",
                    OtherCV="آنا روت بيدال لوانغوا أستاذة اللغة العربية وأدبها في جامعة لاس بالماس دي كران كناريا (إسبانيا). حصلت على الدكتوراه في اللغات السامية بجامعة غرناطة وهي عضو في مجموعتَي البحث: مجموعة السل غير المكتمل والنزاعات (معهد دراسات السلام والنزاعات لجامعة غرناطة) ومجموعة التحليل اللغوي ونشر النصوص (فرع الكفاء الاتصالي والنصوص وتطور التعليم والتعلم في عهد الأنترنيت لجامعة لاس بالماس دي كران كناريا). درست اللغة العربية في تونس والأردن وأقامت بعض الفترات في مصر وفرنسا والمغرب للبحث العلمي.إن قيامها بالبحث العلمي في ميدان الرؤى على السلام والتفاعل مع النزاعات في النطاق العربي والإسلامي أدى بها إلى نشر بعض الأعمال عن دور الوساطة بين العنف والسلم وحول تعدد الثقافات خصوصا في المجال الأدبي. بدأت في السنوات الماضية البحث في ميادين نشر ثقافة السلام عبر تعليم اللغات وتعليم اللغة الإسبانية لغير الناطقين بها (كـلغة إجنبية أو لغة ثانية) خصوصا للمتعلمين العرب. إنها شاركت في مشروع ويبيديوماس وحاليا تقوم بتطوير أبـحاث في إطار هذه المجموعة عن تعليم واسع الإنتشار(ubiquitous learning)لـللغة العربية عبر خدمات الاتصالات وتكنولوجيا المعلومات.",
                    Image="teacher0.jpg",
                },
            };
            return teachers;
        }
    }

    
}